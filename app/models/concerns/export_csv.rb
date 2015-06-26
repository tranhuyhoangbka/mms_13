module ExportCsv
  def as_csv
    CSV.generate do |csv|
      csv << column_names
      all.each {|item| csv << item.attributes.values_at(*column_names)}
    end
  end
end