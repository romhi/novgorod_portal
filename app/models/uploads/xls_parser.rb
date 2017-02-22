
# encoding: utf-8

module Uploads

  class XLSParser

    def initialize(file_path, client)
      @file_path = file_path
      @client = client
      # @upload = upload
    end

    def parse
      book = Spreadsheet.open(@file_path, "rb")
      book.worksheet(0).each do |row|
        vol = Volunteer.new
        # up.status = ""
        # up.upload_date = Time.now
        vol.congregation = @client
        # up.upload_id = @upload.id

        begin
          # Если в конце строки из excel прилетело число с .0 в конце, то обрезаем его
          # str_src = row[@number].to_s.strip
          # str_src.sub!(/.{2}$/,'') if /(\.0$)/ =~ str_src

          vol.last_name = row[0].to_s
          vol.first_name = row[1].to_s
          vol.age = row[2].to_i
          vol.responsibility = Responsibility.find_by_name(row[3].to_i)
          vol.convenient_start_time = row[8].to_s.gsub('-', ':').to_i > 0 ? row[8].to_s.gsub('-', ':').to_datetime : nil
          vol.convenient_end_time = row[9].to_s.gsub('-', ':').to_i > 0 ? row[9].to_s.gsub('-', ':').to_datetime : nil
          vol.will_be_since_8 = row[4].to_s.downcase == 'да' ? 1 : 0
          vol.will_be_until_17 = row[5].to_s.downcase == 'да' ? 1 : 0
          vol.outdoor = row[6].to_s.downcase == 'да' ? 1 : 0
          vol.car = row[7].to_s.downcase == 'да' ? 1 : 0
          vol.phone = row[10].instance_of?(String) ? row[10].gsub(' ', '').gsub('-', '').insert(0, '(').insert(4, ') ').insert(9, '-') : row[10].to_i.to_s.insert(0, '(').insert(4, ') ').insert(9, '-')
          vol.comment = row[11].to_s
          # up.spare_number = str_src
          # up.status = " Номер указан неверно! " if not up.spare_number or not /(\w+|[0-9а-яА-Я]+)/=~ up.spare_number.to_s
          #
          # up.spare_extra_numbers = row[@analog_number].to_s
          #
          #
          # up.spare_vendor = row[@vendor].to_s
          # if up.spare_vendor.present?
          #   up.spare_vendor = up.spare_vendor.slice(0, up.spare_vendor.length - 2) if up.spare_vendor.include?('.0')
          #   up.spare_vendor = up.spare_vendor.upcase
          #   if not Vendor.name_or_alias_present?(up.spare_vendor) or not /(\w+|[а-яА-Я]+)/=~ up.spare_vendor.to_s
          #     up.status += " Производитель указан неверно! "
          #   end
          # end
          #
          # up.spare_name = row[@name].to_s
          # up.status += " Наименование указано неверно! " if not up.spare_name or not /(\w+|[0-9а-яА-Я]+)/=~ up.spare_name.to_s
          #
          # up.quantity = row[@qty]
          # up.status += " Неверно указано кол-во! " if not up.quantity or not /(\d+)/=~ up.quantity.to_s or up.quantity.to_i < 1
          #
          # up.price = row[@price]
          # if up.price
          #   begin
          #     up.price = up.price.round
          #   rescue
          #     up.status += " Неверно указана цена! "
          #   end
          # else
          #   up.status += " Неверно указана цена! "
          # end
          # #up.status += " Неверно указана цена! " if not /(\d+(\.\d+)?)/=~ up.price
          #
          # up.spare_cars_list = row[@car_list]

          vol.save
        rescue Exception => e
          puts e.message
        end
      end
    end

  end

end