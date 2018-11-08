require 'rails_helper'
RSpec.describe Answer, type: :model do
  it "display if a answer have a solution" do
    person = Person.create!
    ticket = person.tickets.create!
    answer = ticket.answers.create!(:have_solution => true)
    expect(answer.have_solution).to be true
  end
end

