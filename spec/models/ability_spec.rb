require 'pry'
require 'rails_helper'
require "cancan/matchers"

describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when it's chief" do
      let(:user){ FactoryGirl.create(:user, :chief) }

      describe "can manage" do
        it_should_behave_like "can manage", [User, Project, Comment, Customer, Contact, Day, Article]
      end

      describe "can manage without create" do
        it_should_behave_like "can manage without create", [RelatedTask, TimeEntry]
      end
    end



    context "when it's developer" do
      let(:user){ FactoryGirl.create(:user, :developer) }
      let!(:project){ user.projects.first}

      describe "can read available user" do
        it_should_behave_like "can read available user"
      end

      describe "can read only this project" do
        it_should_behave_like "can read only this project"
      end

      describe "comment model" do
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :developer, project: user.projects.first)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :developer, project: user.projects.first)) }
        it{ should be_able_to(:read, FactoryGirl.create(:comment, :general, project: user.projects.first)) }

        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general, project: user.projects.first)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial, project: user.projects.first)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:comment, :general, project: user.projects.first)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:comment, :commercial, project: user.projects.first)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :general)) }
      end

      describe "related_task model" do
        it{ should be_able_to(:create, RelatedTask) }
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, user: user)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "manage own time entries" do
        it_should_behave_like "manage own time entries"
      end

      describe "can nothing" do
        it_should_behave_like "can nothing", [Customer, Contact, Day]
      end

      describe "article model" do
        it_should_behave_like "can read and create articles"
      end
    end



    context "when it's manager" do
      let(:user){ FactoryGirl.create(:user, :manager) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "can read available user" do
        it_should_behave_like "can read available user"
      end

      describe "project model" do
        it{ should be_able_to(:manage, project) }
        it{ should be_able_to(:create, Project) }
        it{ should_not be_able_to(:read, Project.new) }
        it{ should_not be_able_to(:manage, Project.new) }
      end

      describe "comment model" do
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :general, project: project)) }
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :general, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :general)) }
      end

      describe "related_task model" do
        it{ should be_able_to(:read, FactoryGirl.create(:related_task, project: project)) }
        it{ should be_able_to(:create, RelatedTask) }
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "manage own time entries" do
        it_should_behave_like "manage own time entries"
      end

      describe "can read" do
        it_should_behave_like "can read", [Customer]
      end

      describe "can manage" do
        it_should_behave_like "can manage", [Contact]
      end

      describe "can nothing" do
        it_should_behave_like "can nothing", [Day]
      end

      describe "article model" do
        it_should_behave_like "can read and create articles"
      end
    end



    context "when it's hr" do
      let(:user){ FactoryGirl.create(:user, :hr) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "can read available user" do
        it_should_behave_like "can read available user"
      end

      describe "can nothing" do
        it_should_behave_like "can nothing", [Project, Comment, RelatedTask, TimeEntry, Day]
      end

      describe "can manage" do
        it_should_behave_like "can manage", [Customer]
      end

      describe "can read" do
        it_should_behave_like "can read", [Contact]
      end

      describe "article model" do
        it_should_behave_like "can read and create articles"
      end
    end



    context "when it's buh" do
      let(:user){ FactoryGirl.create(:user, :buh) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "can read available user" do
        it_should_behave_like "can read available user"
      end

      describe "can nothing" do
        it_should_behave_like "can nothing", [Project, Comment, Day]
      end

      describe "can manage" do
        it_should_behave_like "can manage", [Customer]
      end

      describe "can read" do
        it_should_behave_like "can read", [Contact, RelatedTask, TimeEntry]
      end

      describe "article model" do
        it_should_behave_like "can read and create articles"
      end
    end



    context "when it's teamleader" do
      let(:user){ FactoryGirl.create(:user, :teamleader) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "can read available user" do
        it_should_behave_like "can read available user"
      end

      describe "can read only this project" do
        it_should_behave_like "can read only this project"
      end

      describe "comment model" do
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :general, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :general, project: project)) }

        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :general)) }
      end

      describe "related_task model" do
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, project: project)) }
        it{ should be_able_to(:create, RelatedTask) }
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "manage own time entries" do
        it_should_behave_like "manage own time entries"
      end

      describe "can read" do
        it_should_behave_like "can read", [Customer, Contact]
      end

      describe "can nothing" do
        it_should_behave_like "can nothing", [Day]
      end

      describe "article model" do
        it_should_behave_like "can read and create articles"
      end
    end



    context "when it's customer" do
      let(:user){ FactoryGirl.create(:user, :customer) }
      let!(:customer) { FactoryGirl.create(:customer) }
      let!(:contact) { FactoryGirl.create(:contact, customer: customer) }
      let!(:project) { FactoryGirl.create(:project, customer: customer) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "can nothing" do
        it_should_behave_like "can nothing", [User, Comment, TimeEntry, Day]
      end

      describe "can read only this project" do
        it_should_behave_like "can read only this project"
      end

      describe "related_task model" do
        it{ should be_able_to(:read, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:create, RelatedTask) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "customer model" do
        it{ should be_able_to(:read, customer) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:customer)) }
        it{ should_not be_able_to(:create, Customer) }
        it{ should_not be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, contact) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:contact)) }
        it{ should_not be_able_to(:create, Contact) }
        it{ should_not be_able_to(:manage, Contact) }
      end

      
      describe "can read" do
        it_should_behave_like "can read", [Article]
      end
    end



    context "when it's saler" do
      let(:user){ FactoryGirl.create(:user, :saler) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "can read available user" do
        it_should_behave_like "can read available user"
      end

      describe "can read only this project" do
        it_should_behave_like "can read only this project"
      end

      describe "can nothing" do
        it_should_behave_like "can nothing", [Comment, RelatedTask, TimeEntry, Day]
      end

      describe "can manage" do
        it_should_behave_like "can manage", [Customer, Contact]
      end

      describe "can read" do
        it_should_behave_like "can read", [Article]
      end
    end
  end
end