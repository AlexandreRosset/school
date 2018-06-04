require 'test_helper'

feature "School" do

  describe "#index" do

    it "returns 401 when user isn't autenticated" do
      get api_v1_schools_path

      assert_equal 401, last_response.status
    end

    it "returns 401 when bad token" do
      get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => '123456789'}

      assert_equal 401, last_response.status
    end
    it "returns 200 when good token" do
      get api_v1_schools_path, nil, {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
      assert_equal 2, json_response['schools'].length
    end

    it "returns only private schools" do
      get api_v1_schools_path, {status: 'priver'}, {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
      assert_equal 1, json_response['schools'].length
    end

  end

  describe "#create" do

    it "returns 201 when School is created" do

      assert_difference "School.all.count" do

        post api_v1_schools_path, {school: {nom: 'ecole françois mitterand', email: 'test@test.test'}}, {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 201, last_response.status
      end

    end

    it "doesn't create school when no name given" do

      assert_no_difference "School.all.count" do

        post api_v1_schools_path, {school: {name: ""}}, {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 422, last_response.status
      end

    end

  end

  describe "#show" do

    it "return the right school by the ID" do

      get api_v1_school_path(1), nil, {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
    end

  end

  describe "#update" do

    it "return 200 when school updated" do

      patch api_v1_school_path(1), {school: { nom: "first school bis"}},  {'HTTP_AUTHORIZATION' => 'valid_token'}

      assert_equal 200, last_response.status
      assert_equal "first school bis", json_response['school']['nom']
    end

  end

  describe "#delete" do

    it "return 200 when school is successfully deleted" do

      assert_difference "School.all.count", -1 do

        delete api_v1_school_path(1), nil, {'HTTP_AUTHORIZATION' => 'valid_token'}

        assert_equal 200, last_response.status

      end

    end

  end

end
