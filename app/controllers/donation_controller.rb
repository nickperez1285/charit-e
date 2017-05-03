class DonationController < ApplicationController
	layout false 
	def index 

 client = DocusignRest::Client.new


	end 
	def confirm

client = DocusignRest::Client.new
@template_response = client.create_template(
  description: 'Confirm page',
  name: "Confirm page",
  signers: [
    {
      embedded: true,
      name: 'nick perez',
      email:  'nickperez1285@gmail.com',
      role_name: 'Web Dev',
   
    },
  ],
  files: [
    {path: '/Users/Nicks_Home/Desktop/docusign/Techb/pledger.pdf', name: 'pledger.pdf'},
  ]
)

client = DocusignRest::Client.new
@envelope_response = client.create_envelope_from_template(
  status: 'sent',
  email: {
    subject: "Pledge Confirmation Form",
    body: "Please Confirm Your Pledge Payment to TechBridge"
  },
  # template_id: @template_response["templateId"],
  template_id: "6263260c-9993-43d8-89db-78947e956982",
  signers: [
    {
      embedded: true,
      name: 'nick perez',
      email: 'nickperez1285@gmail.com',
      role_name: 'Web Dev'
    }
  ]
)
client = DocusignRest::Client.new
  url = client.get_recipient_view(
        envelope_id: @envelope_response["envelopeId"],
        name: 'nick perez',
        email: 'nickperez1285@gmail.com',
        return_url: 'http://localhost:3000/donation/docusign_response',
       )

    @view =(url.map{|x,y| y})[0]

	end

  def docusign_response 
    utility = DocusignRest::Utility.new 
    if params[:event] == "signing_complete"
      # render :text => utility.breakout_path(root_path), content_type: :html
      redirect_to root_path
    else 
       flash[:notice] = "document not signed"
       # render :text => utility.breakout_path(root_path), content_type: :html
      redirect_to root_path


    end 
  end 

def breakout_path(path)
  "<html><body><script type='text/javascript' charset='utf-8'>parent.location.href = '#{path}';</script></body></html>"
end
# 	private 
# 	def donate_params
# 	params.require(:donate).permit(:twentyfive, :fifty, :hundred, :twohundredfifty, :custom , :recurring)
# end
# tax_site = https://www.irs.gov/pub/irs-pdf/f1024.pdf
end
