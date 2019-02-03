require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    describe 'GET #new' do
        it 'renders the new user signup page' do
            get :new
            expect(response).to render_template('new')
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET #show' do
        it 'renders the show user page' do
            
            post :create, params: { user: {username: 'Billy', password: 'password'}}

            get :show, params: { id: User.last.id }
            expect(response).to render_template('show')
            expect(response).to have_http_status(200)
        end
    end


    describe 'POST #create' do
        context 'with invalid params' do
            it 'redirects user to sign up again and shows errors' do  
                post :create, params: { user: {username: 'Billy', password: '1'}}
                expect(response).to render_template('new')
                expect(flash[:errors]).to be_present
            end
        end 
        
        context 'with valid params' do
            it 'shows the users goals and signs them in' do 
                post :create, params: { user: {username: 'Billy', password: 'password'}}
                expect(response).to redirect_to(user_url(User.last))
                expect(response).to have_http_status(302)
            end
        end 
    end


end
