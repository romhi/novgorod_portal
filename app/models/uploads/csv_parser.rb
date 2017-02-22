# encoding: utf-8

module Uploads

  class CSVParser

    def initialize(file_path, client, upload)
      @file_path = file_path
      @client = client
      @upload = upload
    end

    def parse

      CSV.foreach(path, :quote_char => '"', :col_sep =>';', :row_sep =>:auto) do |row|
        up = ProductUploading.new
        up.status = nil
        up.upload_date = Time.now
        up.supplier = client
        up.upload_id = @upload.id

        begin
          # Если в конце строки из excel прилетело число с .0 в конце, то обрезаем его
          str_src = row[0].to_s.strip
          str_src.sub!(/.{2}$/,'') if /(\.0$)/ =~ str_src

          up.spare_number = str_src
          up.status = " Номер указан неверно! " if not up.spare_number or not /(\w+|[0-9а-яА-Я]+)/=~ up.spare_number.to_s

          up.spare_extra_numbers = row[1].to_s

          up.spare_vendor = row[2].to_s
          if up.spare_vendor.present?
            up.spare_vendor = up.spare_vendor.slice(0, up.spare_vendor.length - 2) if up.spare_vendor.include?('.0')
            if not Vendor.name_or_alias_present?(up.spare_vendor) or not /(\w+|[а-яА-Я]+)/=~ up.spare_vendor.to_s
              up.status += " Производитель указан неверно! "
            end
          else
            up.spare_vendor_id = Vendor.by_name_or_alias(up.spare_vendor).first.id
          end

          up.spare_name = row[3].to_s
          up.status += " Наименование указано неверно! " if not up.spare_name or not /(\w+|[0-9а-яА-Я]+)/=~ up.spare_name.to_s

          up.quantity = row[4]
          up.status += " Неверно указано кол-во! " if not up.quantity or not /(\d+)/=~ up.quantity.to_s or up.quantity.to_i < 1

          up.price = row[5]
          if up.price
            begin
              up.price = up.price.round
            rescue
              up.status += " Неверно указана цена! "
            end
          else
            up.status += " Неверно указана цена! "
          end
          #up.status += " Неверно указана цена! " if not /(\d+(\.\d+)?)/=~ up.price

          up.spare_cars_list = row[6]

          up.save
        rescue Exception => e
          puts e.message
        end
      end

    end

  end

end