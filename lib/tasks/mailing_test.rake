namespace :mailing do
    desc "Process tickets (; separator)"
    task :test, [:text] => [:environment] do |t, args|
      args.with_defaults(text: "Testing")

 
      AlertMailer.send_mail_success(args.text).deliver_now
      puts "Correo enviado"
    end
end
  