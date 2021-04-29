class StringUtils

  def normalize_phone(phone)
    if phone.blank? then nil
      else
        begin
          phone = phone.to_s.strip
          phone = phone.remove('(',')',' ','-',' ')

          phone_starting = phone[0..1]
          if phone.length == 8 
            phone_new = "+569#{phone}"
          elsif phone.length < 9 
            nil
          elsif phone[0..4] == '+5609' && phone.length == 13
            phone_new = "+569#{phone[5..13]}"
          elsif phone_starting == '56' && phone.length == 11
            phone_new = "+#{phone}"
          elsif phone.length == 9 && phone_starting != '56'
            phone_new = "+56#{phone}"
          elsif phone_starting == '09' || phone_starting == '02' 
            phone_new = "#{phone_starting.gsub('0','+56')}#{phone[1..8]}"
          elsif phone_starting == '99' &&  phone.length == 10
            phone_new = "+56#{phone[1..9]}"
          elsif phone.length == 11
            phone_new = "+#{phone}"
          elsif phone[0..2] == '+56' && phone.length == 12
            phone_new = phone
          end
          phone = phone_new
        rescue
          nil 
        end
      end
  end
  
  def normalize_rut(rut)
    if rut.blank? || rut.length < 7 then nil
    else
      begin
        rut = rut.strip.remove('.','_',' ').downcase
        if !rut.include?('-') 
          rut = rut.insert(-2,'-')
        end

        if !rut.rut_valid? 
          rut = rut[1..-3]
          #check the verify number
          if verify_digit(rut) == nil then nil
          else
            rut << '-' << verify_digit(rut)

            if !rut.rut_valid? then nil
            else
              #return rut removing the verify digit
              rut = rut[1..-3]
              rut
            end
          end
        else
          #return rut removing the verify digit
          rut = rut[1..-3]
          rut
        end
      rescue ArgumentError => e
        puts " ! Error in normalize_rut(#{rut}): #{e.message}".colorize(:light_red)
        nil
      end
    end
  end

  def verify_digit(rut)
    if rut.blank? then nil
    else
      begin
        serial = [2,3,4,5,6,7]
        acum,index,result = 0,0,0

        rut.reverse.each_char do |digit|
          digit = digit.to_i
          acum = acum + (digit * serial[index])
          index += 1  
          if index > 5
            index = 0
          end
        end
        result = 11-(acum%11)
        if result == 10
          return 'k'
        elsif result == 11
          return '0'
        else
          result.to_s
        end
      rescue
        nil
      end
    end
  end

  def normalize_mail(mail)
    if mail.present? && mail.include?('@') && mail.include?('.')
      mail = mail.strip.downcase
    else 
      nil
    end
  end

  def normalize_query_field(field)
    if field.blank? then nil 
    else 
      field = field.strip.upcase 
    end
  end

end