require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  describe "Fetch all Todo lists" do

    context 'For authorized request' do
      before do 
        @test_list_1 = create(:todo_list)
        @test_list_2 = create(:todo_list, title: "Test list 2", description: "Test Description 2")
        get '/api/v1/todo_lists', headers: {'Authorization' => "Token token=aym-te$T"}
      end

      it 'excepts status to be success and fetches the todo lists' do
        expect(response).to be_success
        @expected = [{"id": @test_list_2.id,"title": @test_list_2.title,"description": @test_list_2.description,"todo_tasks": []},{"id": @test_list_1.id,"title": @test_list_1.title,"description": @test_list_1.description,"todo_tasks": []}]
        expect(JSON.parse(response.body, {:symbolize_names => true})).to eq(@expected)
      end
    end

    context 'For un authorized request' do
      before do 
        create(:todo_list)
        create(:todo_list, title: "Test list 2", description: "Test Description 2")
        get '/api/v1/todo_lists'
      end

      it 'excepts status to be 403 fro un authorized requests' do
        expect(response.status).to eq(403)
      end

    end
  end

  describe "Fetch a Todo list" do

    context 'Authorized request' do
      before do 
        @test_list_1 = create(:todo_list)
        @test_list_2 = create(:todo_list, title: "Test list 2", description: "Test Description 2")
      end

      it 'excepts status to be success and fetches details of a todo list with given id' do
        get "/api/v1/todo_lists/#{@test_list_1.id}", headers: {'Authorization' => "Token token=aym-te$T"}
        expect(response).to be_success
        @expected = {"id": @test_list_1.id,"title": @test_list_1.title,"description": @test_list_1.description,"todo_tasks": []}
        expect(JSON.parse(response.body, {:symbolize_names => true})).to eq(@expected)
      end

      it 'Raise error when given invalid id and returns status' do
        get "/api/v1/todo_lists/42342", headers: {'Authorization' => "Token token=aym-te$T"}
        expect(response.status).to eq(404)
      end

    end

  end

  describe "Create a Todo List" do

    context 'Authorized request' do

      it 'creates a todo for valid parameters' do
        post '/api/v1/todo_lists', params: { title: 'Test Title', description: "Test Description" }, headers: {'Authorization' => "Token token=aym-te$T"}
        res = JSON.parse(response.body)
        expect(res['title']).to eq('Test Title')
      end

      it 'Returns status 400 for invalid title' do
        post '/api/v1/todo_lists', params: { title: '', description: "Test Description" }, headers: {'Authorization' => "Token token=aym-te$T"}
        expect(response.status).to eq(400)
      end

    end

  end


  describe "Delete a Todo List" do

    context 'Authorized request' do

      before do 
        @test_list_1 = create(:todo_list)
        @test_list_2 = create(:todo_list, title: "Test list 2", description: "Test Description 2")
      end

      it 'Deletes a Todo list of given id' do
        delete "/api/v1/todo_lists/#{@test_list_1.id}", headers: {'Authorization' => "Token token=aym-te$T"}
        expect(response).to be_success
        expect(JSON.parse(response.body)["msg"]).to eq("Successfully deleted record")
      end

      it 'Returns status 404 for invalid if' do
        delete '/api/v1/todo_lists/42342', headers: {'Authorization' => "Token token=aym-te$T"}
        expect(response.status).to eq(404)
      end

    end

  end
end