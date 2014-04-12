require "sinatra"
require "braintree"
require "awesome_print"

get "/" do
  erb :index
end

post "/create" do
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = "krfw6vjpntwc8ngf"
  Braintree::Configuration.public_key = "ktj2yhb84kcthxcx"
  Braintree::Configuration.private_key = "3720bfff590f9e0d4994b0df48199f49"

  result = Braintree::Transaction.sale(
    amount: "10.00",
    credit_card: {
      token: "trasaction_#{rand(1..1_000_000)}",
      number: params[:number],
      expiration_month: params[:month],
      expiration_year: params[:year],
      cvv: params[:cvv]
    },
    options: {
      submit_for_settlement: true
    }
  )
  ap result
  erb :create, locals: { transaction: result.transaction }
end