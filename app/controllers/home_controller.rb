class HomeController < ApplicationController
	layout false 
	def embedded_signing 
		@client = DocusignRest::Client.new
    @template_response = @client.create_template(
  description: "Template Description",
  name: "Template Namer",
  signers: [
    {
      embedded: true,
      name: 'jon',
      email: 'someone@gmail.com',
      role_name: 'Issuer',
      sign_here_tabs: [
        {
          anchor_string: 'issuer_sig',
          anchor_x_offset: '140',
          anchor_y_offset: '8'
        }
      ]
    }
  ],
  files: [
    {path: '/Users/Nicks_Home/Desktop/docusign/Techb/test.pdf', name: 'test.pdf'}
  ]
)
 
 # @envelope_response = @client.create_envelope_from_template
@url = @client.get_recipient_view(

  templateId: @template_response["templateId"],
  # name: current_user.display_name, 
  # email: current_user.email, 
  # envelope_id: 1,
  templateRoles:[{
     name: 'jon',
      email: 'someone@gmail.com',
      role_name: 'Issuer',
    }]
    status: "sent", 
  return_url: "http://localhost:3000/success"
  )



	end 

  def docusign_response 
    utility = DocusignRest::Utility.new 
    if params[:event] == "signing_complete"
      flash[:notice] = "success"
      render :text => utility.breakout_path(:action => "success"), content_type: :html
    else 
       flash[:notice] = "document not signed"
       render :text => utility.breakout_path(:action => "fail"), content_type: :html


    end 
  end 

  def success
    
  end 
  def fail 
  end 

end
