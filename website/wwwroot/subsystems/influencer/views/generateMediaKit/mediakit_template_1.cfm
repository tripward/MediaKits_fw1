
<!---<cfdump var="#rc.influencerAccount.getProfile()#" label="cgi" abort="true" top="30" />--->
<cfoutput>
	<cfsavecontent variable="request.MediaKitContent" >
	<table id="mediakit">
		<tr>
			<td><img src="C:\mediaFiles\headshots\#rc.influencerAccount.getProfile().getheadshotFilename()#"></td>
			<td><img src="/mediaFiles/headshots/#rc.influencerAccount.getProfile().getheadshotFilename()#"></td>
			<td><img src="/#rc.influencerAccount.getProfile().getheadshotFilename()#"></td>
			<td>
				<div>#rc.influencerAccount.getfirstname()# #rc.influencerAccount.getlastname()#</div>
				<div>#rc.influencerAccount.getemail()#</div>
				
				<div id="identity-statistics">
                    <h3>Followers</h3>
                    <hr/>
                    <table>
                        <cfif len(trim(rc.influencerAccount.getProfile().getfacebookLongLivedAccessToken()))>
                            <tr>
                                <td id="fbFriendCount" class="value" >2</td>
                            </tr>
                        </cfif>

                        <cfif len(trim(rc.influencerAccount.getProfile().getinstagramUserName()))>
                            <tr>
                                <td class="variable">Instagram</td>
                                <td id="instagram-followers" class="value" >#rc.influencerAccount.getProfile().getinstagramfollowed_by()#</td>
                            </tr>
                        </cfif>
                            
                            
                        <cfif len(trim(rc.influencerAccount.getProfile().gettwitterUserName()))>
                            <tr>
                                <td class="variable">Twitter</td>
                                <td id="twitter-followers" class="value" >#rc.socialStats.twitter.stats.asStruct.followers_count#</td>
                            </tr>
                        </cfif>
               
                        <cfif len(trim(rc.influencerAccount.getProfile().getPintrestUserName())) AND structKeyExists(rc.socialStats,'pintrest')>
                            <tr>
                                <td class="variable">Pinterest</td>
                                <td id="pintrestFollowerCount" class="value"><span id="boardCount">#rc.socialStats.pintrest.stats.PINTRESTFOLLOWERCOUNT# (#rc.socialStats.pintrest.stats.PINTRESTBOARDCOUNT# boards)</span></td>
                            </tr>
                        </cfif>
                            
                    </table>

                </div>

				<!---<div>Blog URL #rc.influencerAccount.getProfile().getblogURL()#</div>
				<div>Web URL #rc.influencerAccount.getProfile().getwebURL()#</div>
				<div>Keywords #rc.influencerAccount.getProfile().getkeywords()#</div>
				<div>Description #rc.influencerAccount.getProfile().getdescription()#</div>--->
			</td>
		</tr>
		<!---<tr>
			<td colspan="3">
				<div class="">Facebook Friend Count #rc.socialMediaStats.facebookFriendsCount#</div></td>
				<div class="">Instagram Follower Count #rc.socialMediaStats.instagramFollowersCount#</div>
				<div class="">Pintrest Follower Count #rc.socialMediaStats.pintrestFollowersCount#</div>
				<div class="">Twitter Follower Count #rc.socialMediaStats.twitterFollowersCount#</div>
			</td>
		</tr>--->
	</table>

<!---<cfdump var="#rc.influencerAccount#" label="cgi" abort="true" top="3" />--->

	<!---<cfif rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().hasNext()>
		<cfloop condition="rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().hasNext()">
			<cfset cat = rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().next()>
			<cfdump var="#cat#">
		</cfloop>
	<cfelse>
		<p>No members exist.</p>
	</cfif>--->
	
	<!---<cfif rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().hasNext()>
            1
        </cfif>--->
        <!---<cfloop condition="rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().hasNext()">
            <cfset item=rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().next()>
             
            <div class="col-md-3">
                <div class="well">
                   "#item.getDEMOGRAPHICID()#"

                </div>
            </div>
        </cfloop>
        <cfdump var="#rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().getArray()#" label="cgi" abort="true" top="3" />--->
        
	<!---<cfdump var="#rc.influencerAccount.getProfile().getInfluencerProfileToDemographics().GETARRAY()#" label="cgi" abort="true" top="3" />--->
	<!---<h4>Demographics</h4>
	<div id="demographics" class="form-group">
		<cfloop list="#rc.demographics#" index="local.myDemo" delimiters="^" >
			<cfif listFindNoCase(rc.currentInfluencerDemographics,listFirst(local.myDemo,'|'))><div>#listLast(local.myDemo,'|')#</div></cfif>  
		</cfloop>
	</div>--->
	
	<!---<h4>Categories</h4>
	<div id="categories" class="form-group">
		<cfloop list="#rc.categories#" index="local.myCat" delimiters="^" >
			<cfif listFindNoCase(rc.influencerAccount.currentInfluencerCategories,listFirst(local.myCat,'|'))><div>#listLast(local.myCat,'|')#</div></cfif>
		</cfloop>
		<a href="foo" id='categories_EditLink'>Edit</a>
		
		<!---<cfdump var="#rc.influencerAccount.getProfile().getInfluencerProfileToCategories().getArray()#" label="cgi" abort="false" top="3" />--->
	</div>--->
			
			
	</cfsavecontent>

#request.MediaKitContent#
<!---<cfheader name="Content-disposition"  value="attachment;filename=#rc.influencerAccount.getfirstname()#_#rc.influencerAccount.getLasttname()#.pdf" />
<cfcontent type="application/pdf" />
<cfdocument format="PDF">
	#request.MediaKitContent#
</cfdocument>--->
</cfoutput>