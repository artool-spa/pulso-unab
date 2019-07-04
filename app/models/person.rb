class Person < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :log_mailer_sends, dependent: :destroy

  def self.person_tickets_count
    Person.all.each do |person|
      puts "person_name: #{person.full_name} #{person.tickets.count}" if person.tickets.count > 10
    end
  end
  
end
