class PaymentController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'net/https'
  PAYU_IN_TEST_PAYMENT_URL = "https://test.payu.in/_payment.php"
  PAYU_IN_LIVE_PAYMENT_URL = "https://secure.payu.in/_payment"

  include PaymentHelper
  before_action :check_current_user
  before_action :capture_params, only: [:success, :failure]
  skip_before_action :verify_authenticity_token, only: [:success, :failure]

  def index
    #merge!( response["transaction_details"] && response["transaction_details"].size == 1 ? response["transaction_details"].values.first : ( response["transaction_details"] || { :status => response['msg'] } ) )
  end

  def issue_payment
    mode = case params[:type]
    when "DEBIT/CREDIT CARD" then "CC"
    when "NET BANKING" then "NB"
    end

    payment_params = build_payment_params mode

    url = URI.parse(PAYU_IN_TEST_PAYMENT_URL)

    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true

    resp, data = con.post url.path, payment_params.to_query

    location = resp['location']

    redirect_to URI.parse(location).to_s

  end

  def success
    add_charge = params["additionalCharges"]
    status = params["status"]
    posted_hash = params["hash"]

    checksum_hash = checksum status, add_charge
    @patient = Patient.find_by_name current_user.name

    if checksum_hash != posted_hash
      @error = "Invalid Checksum!"
      @patient.update({pay_status: "payment failed"})
      render 'failure'
    else
      @patient.update({pay_status: "paid"})
      render 'success'
    end
  end

  def failure
    @patient = Patient.find_by_name current_user.name
    @patient.update({pay_status: "payment failed"})
    @error = params['error_Message']
    render 'failure'
  end

  private

  def check_current_user
    unless current_user
      redirect_to '/new_patient'
    end
  end

  def capture_params
    mihpayid = params["mihpayid"] #	Unique reference no. created at PayUbiz’s end for each transaction.
    mode	= params["mode"]        # Payment category by which the transaction was completed/ attempted.
    pg_type = params["PG_TYPE"]	  # Gives the information of payment gateway used for transaction.	 HDFCPG/SBIDI/INDUSPG
    bank_ref_num = params["bank_ref_num"]	# For a successful transaction, this will give you the bank reference number generated at bank’s end	  116646101
  end
end
