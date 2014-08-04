require 'rails_helper'

describe EasyUnionSet do
  it "is included in AR::Relation" do
    expect(ActiveRecord::Relation).to include(EasyUnionSet::GroupMethods)
  end

  it "allows me to make a union" do
    create_list(:project, 10)
    expect((Project.where("title LIKE '%a%'") | Project.where("title LIKE '%e%'")).to_sql).to include('UNION')
  end

  it "allows me to make an intersection" do
    create_list(:project, 10)
    expect((Project.where("title LIKE '%a%'") & Project.where("title LIKE '%e%'")).to_sql).to include('INTERSECT')
  end

  it "allows me to combine multiple intersections and unions" do
    create_list(:project, 20)
    query = ->{ Project.where("title LIKE '%a%'") | Project.where("description LIKE '%e%'") & Project.where("description LIKE '%a%'") }
    expect(&query).to_not raise_error
    expect(query.call.to_sql).to include('UNION', 'INTERSECT')
  end

  describe "the return value of unions and sets" do
    it "is accurate when using 3 ar:objects where each individual obj matches one of the querries" do
      project1 = create(:project, :title => "George's project")
      project2 = create(:project, :description => "some proj")
      project3 = create(:project, :category => "projectile")
      
      expect(Project.where("title LIKE '%proj%'") | Project.where("description LIKE '%proj%'") | Project.where("category LIKE '%proj%'")).to include(project1, project2, project3)
    end

    it "returns the same object 3 times if it matches 3 of the querries using a union all" do
      project = create(:project, :title => "George's project", :description => "some proj", :category => "projectile")

      expect(Project.where("title LIKE '%proj%'") | {all: Project.where("description LIKE '%proj%'")} | {all: Project.where("category LIKE '%proj%'")}).to include(project)
      expect((Project.where("title LIKE '%proj%'") | {all: Project.where("description LIKE '%proj%'")} | {all: Project.where("category LIKE '%proj%'")}).count).to eq(3)
    end

    it "returns 1 object using a set if the object matches all 3 querries" do
      project = create(:project, :title => "George's project", :description => "some proj", :category => "projectile")

      expect(Project.where("title LIKE '%proj%'") & Project.where("description LIKE '%proj%'") & Project.where("category LIKE '%proj%'")).to include(project)
    end

    it "does not return anything if one of the queries using a set doesnt match anything" do
      create(:project, :title => "George's project", :description => "some proj", :category => "projectile")

      expect(Project.where("title LIKE '%proj%'") & Project.where("description LIKE '%proj%'") & Project.where("category LIKE 'blahblah'")).to be_empty
    end

  end

  it "still allows me to make ruby unions and intersects by using the to_a method" do
      project = create(:project, :title => "George's project", :description => "some proj", :category => "projectile")
      
    expect(Project.where("title LIKE '%proj%'").to_a & Project.where("description LIKE '%proj%'").to_a & Project.where("category LIKE '%proj%'").to_a).to include(project)
  end
end