namespace :qr_maker do
  desc "QR Maker"
  task :all, [:date_from, :date_to] => [:environment] do |t, args|
    args.with_defaults(date_from: nil, date_to: nil, debug_mode: false)
    date_curr = DateTime.current
    # Set initial retrieving period for stats
    if args.date_from.present? && args.date_to.present?
      date_from = DateTime.parse(args.date_from)
      date_to = DateTime.parse(args.date_to)
    else
      date_from = (date_curr - 2.days).beginning_of_day
      date_to = date_curr.end_of_day
    end
    webs = ["http://facebook.com/","http://google.com/"]
    webs.each do |t|
      qrcode = RQRCode::QRCode.new(t)
      # With default options specified explicitly
      png = qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 400,
      border_modules: 4,
      module_px_size: 6,
      file: "../../QR_codes/github-qrcode-#{webs.find_index(t)}.png" # path to write
      )
    end
  end 
end