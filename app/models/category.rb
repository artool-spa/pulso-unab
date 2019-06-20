class Category < ApplicationRecord
  has_ancestry

  def self.set_categories_to_ticket(ticket)
    Ticket.transaction do
      Category.where("id = ?", ticket.category_id).each do |category|
        if category.ancestors.length == 3
          ticket.category_1 = category.ancestors[0].name
          ticket.category_2 = category.ancestors[1].name
          ticket.category_3 = category.ancestors[2].name
          ticket.category_4 = category.name

        elsif category.ancestors.length == 2
          ticket.category_1 = category.ancestors[0].name
          ticket.category_2 = category.ancestors[1].name
          ticket.category_3 = category.name

        elsif category.ancestors.length == 1
          ticket.category_1 = category.ancestors[0].name
          ticket.category_3 = category.name
        end

        ticket.save
      end
    end
  end

  def self.add_categories_to_all_tickets
    Ticket.all.each do |ticket|
      Category.where("id = ?", ticket.category_id).each do |category|
        if category.ancestors.length == 3
          ticket.category_1 = category.ancestors[0].name
          ticket.category_2 = category.ancestors[1].name
          ticket.category_3 = category.ancestors[2].name
          ticket.category_4 = category.name

        elsif category.ancestors.length == 2
          ticket.category_1 = category.ancestors[0].name
          ticket.category_2 = category.ancestors[1].name
          ticket.category_3 = category.name

        elsif category.ancestors.length == 1
          ticket.category_1 = category.ancestors[0].name
          ticket.category_3 = category.name
        end
        puts ticket.crm_ticket_id
        ticket.save
      end
    end
  end

end
