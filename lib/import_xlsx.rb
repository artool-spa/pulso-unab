require "creek"

class ImportXlsx
  # Load xlsx file
  def load_file(filename, &block)
    creek = Creek::Book.new filename
    sheet = creek.sheets[0]

    first = true
    header = []
    sheet.rows.each_with_index do |row, i|
      if first
        header = row.values.compact.map{ |item| item.downcase.to_sym }
        first = false
      else
        datum = Hash[header.zip row.values]
        yield(i+1, datum)
      end
    end
  end
end
