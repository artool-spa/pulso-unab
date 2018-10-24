# Clients
[
  { name: "Cumplo",               fb_ad_account_id: 458896964495063,  ga_ad_account_id: "995-283-8313", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "DSAE",                 fb_ad_account_id: 457120384672721,  ga_ad_account_id: "511-956-4472", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Vida Nueva",           fb_ad_account_id: 348547398863354,  ga_ad_account_id: "946-760-9801", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Castro y Tagle",       fb_ad_account_id: 545165322534893,  ga_ad_account_id: nil,            fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: false },
  { name: "Convet",               fb_ad_account_id: 533399160378176,  ga_ad_account_id: nil,            fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "MPC",                  fb_ad_account_id: 425640991153994,  ga_ad_account_id: "222-534-3600", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "MQ Inside La Dehesa",  fb_ad_account_id: 555568624827896,  ga_ad_account_id: nil,            fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: false },
  { name: "Cities",               fb_ad_account_id: 557668777951214,  ga_ad_account_id: nil,            fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: false },
  { name: "Napoleón/Urmeneta",    fb_ad_account_id: 456733488044744,  ga_ad_account_id: "724-879-8754", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: false },
  { name: "3L",                   fb_ad_account_id: 2119207234965249, ga_ad_account_id: "305-713-8242", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Carmela Shoes",        fb_ad_account_id: 557308757987216,  ga_ad_account_id: "447-366-3311", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "DBS",                  fb_ad_account_id: 170131430283280,  ga_ad_account_id: "511-163-1923", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "The North Face",       fb_ad_account_id: 1898896643455979, ga_ad_account_id: "722-064-2400", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Kivul",                fb_ad_account_id: 495027634215329,  ga_ad_account_id: nil,            fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "DC Shoes",             fb_ad_account_id: 474810426237050,  ga_ad_account_id: "838-057-8113", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Clínica Terré",        fb_ad_account_id: 386438441740916,  ga_ad_account_id: "195-803-3063", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Newfield",             fb_ad_account_id: 409909419393818,  ga_ad_account_id: "791-906-7776", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Newfield USA",         fb_ad_account_id: 524857261232366,  ga_ad_account_id: nil,            fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "FPP",                  fb_ad_account_id: 529130047471754,  ga_ad_account_id: "764-947-4082", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Uno Salud",            fb_ad_account_id: 630829763951062,  ga_ad_account_id: "717-532-2539", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Simce",                fb_ad_account_id: 0,                ga_ad_account_id: "695-359-6433", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: true },
  { name: "Ecomac",               fb_ad_account_id: 0,                ga_ad_account_id: "973-516-3574", fb_dollar_conv: 700, ga_dollar_conv: 1, is_enabled: false },
].each do |v|
  Client.find_or_create_by(v)
end
