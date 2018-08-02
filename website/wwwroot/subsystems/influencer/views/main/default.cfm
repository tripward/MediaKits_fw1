
<cfsilent>
	
</cfsilent>

<cfoutput>
<cfinclude template="/layouts/messages.cfm" >
<!---<cfdump var="#rc#" label="cgi" abort="false" top="3" />--->

<!---<div class=""><a href="/infuencer-profile/generate-media-kit/#buildURL('generateMediaKit:main.default&influenceraccountid=#rc.influencerAccount.getID()#')#">Generate MediaKit</a></div>--->

<div id="status"></div>

<div class="row">
	<div class="col-md-3">
        
         <section id="identity">
            
                <div id="identity_image">

                    <h2>Patrick Tisdel</h2>
                    <p>Subscription active</p>

                </div>

                <div id="identity-statistics">
                    <h3>Followers</h3>
                    <hr/>
                    <table>
                        <cfif len(trim(rc.influencerAccount.getProfile().getfacebookLongLivedAccessToken()))>
                            <tr>
                                <td class="variable">Facebook <a class="edit-link" href="/index.cfm?action=influencer:facebookSetup.default">(edit)</a></td>
                                <td id="fbFriendCount" class="value" >2</td>
                            </tr>
                        <cfelse>
                            <tr>
                                <td class="variable">Facebook</td>
                                <td id="fbFriendCount" class="value" ><a class="add-link" href="/index.cfm?action=influencer:facebookSetup.default">Add</a></td>
                            </tr>
                        </cfif>

                        <cfif len(trim(rc.influencerAccount.getProfile().getinstagramUserName()))>
                            <tr>
                                <td class="variable">Instagram <a class="edit-link" href="/index.cfm?action=influencer:InstagramSetup.default">(edit)</a></td>
                                <td id="instagram-followers" class="value" >#rc.influencerAccount.getProfile().getinstagramfollowed_by()#</td>
                            </tr>
                        <cfelse>
                            <tr>
                                <td class="variable">Instagram</td>
                                <td id="instagram-followers" class="value" ><a class="add-link" href="/index.cfm?action=influencer:InstagramSetup.default">Add</a></td>
                            </tr>
                        </cfif>
                            
                            
                        <cfif len(trim(rc.influencerAccount.getProfile().gettwitterUserName()))>
                            <tr>
                                <td class="variable">Twitter <a class="edit-link" href="/index.cfm?action=influencer:twitterSetup.default">(edit)</a></td>
                                <td id="twitter-followers" class="value" >#rc.socialStats.twitter.stats.asStruct.followers_count#</td>
                            </tr>
                        <cfelse>
                            <tr>
                                <td class="variable">Twitter</td>
                                <td id="twitter-followers" class="value" ><a class="add-link" href="/index.cfm?action=influencer:twitterSetup.default">Add</a></td>
                            </tr>
                        </cfif>
                            
                        <cfif len(trim(rc.influencerAccount.getProfile().getPintrestUserName()))>
                            <tr>
                                <td class="variable">Pinterest <a class="edit-link" href="/index.cfm?action=influencer:pintrestSetup.default">(edit)</a></td>
                                <td id="pintrestFollowerCount" class="value"><span id="boardCount">#rc.socialStats.pintrest.stats.PINTRESTFOLLOWERCOUNT# (#rc.socialStats.pintrest.stats.PINTRESTBOARDCOUNT# boards)</span></td>
                            </tr>
                        <cfelse>
                            <tr>
                                <td class="variable">Pinterest</td>
                                <td id="twitter-followers" class="value" ><a class="add-link" href="/index.cfm?action=influencer:pintrestSetup.default">Add</a></td>
                            </tr>
                        </cfif>
                            
                    </table>

                </div>
                            
                            
                <div id="google-analytics-section" class="dark">
                    
                    <h3>Google Analytics</h3>
                    <hr/>
                    
                    <div class="field">
                        <input id="googleAnalyticsUserName" disabled type="text" required pattern=".{1,}" name="username" value="#rc.influencerAccount.getProfile().getgoogleAnalyticsUserName()#"/>
                        <label for="googleAnalyticsUserName">Username</label>
                        <a class="edit-link" href="##" id='googleAnalytics_EditLink'>(edit)</a>
                    </div>
                            
                            
                </div>
                            
                            <!---                    <a href="" id='award_delete_#local.award.getawardid()#'>Delete</a>--->

                            
                <div class="accomplishment-section">
                    <h3>Awards</h3>
                    <hr/>
                    
                    <cfif arrayLen(rc.influencerAccount.getProfile().getAwards())>
                        <div>  
                            <cfloop array="#rc.influencerAccount.getProfile().getAwards()#" index="local.award">
                                  <table class="accomplishment">  

                                         <tr>
                                            <td class="title">#local.award.getname()# <a id="award_edit_#local.award.getAwardid()#" class="edit-link" href="##">(edit)</a></td>
                                            <td class="date">#local.award.getPresentedDate()#</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="description">
                                                #local.award.getDescription()# #local.award.getPresentedBy()#
                                            </td>
                                        </tr>

                                 </table>

                            </cfloop>
                       </div>
                    <cfelse>
                        <div>No awards added yet.</div>
                    </cfif>

                    <a id="add-award" href="##" class="modal-link btn add-item-button">Add Award</a>
                </div>
                    
                    
                 <div class="accomplishment-section">
                    <h3>Press Links</h3>
                    <hr/>
                    
<!---                     <a href="" id='presslink_delete_#local.presslink.getpresslinkid()#'>Delete</a->--->
                     
                    <cfif arraylen(rc.influencerAccount.getProfile().getPresslinks())>
                        <div>  
                            <cfloop array="#rc.influencerAccount.getProfile().getPresslinks()#" index="local.presslink">
                                  <table class="accomplishment">  

                                         <tr>
                                            <td class="title">#local.presslink.getname()# <a id="presslink_edit_#local.presslink.getpresslinkid()#" class="edit-link" href="##">(edit)</a></td>
                                            <td class="date">#local.presslink.getDisplayDate()#</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="description">
                                                #local.presslink.getDescription()# #local.presslink.getpublication()#
                                            </td>
                                        </tr>

                                 </table>

                            </cfloop>
                       </div>
                    <cfelse>
                        <div>No press links added yet.</div>
                    </cfif>

                    <a id="add-press-link" href="##" class="modal-link btn add-item-button">Add Press Link</a>
                </div>   
                     
                 
                    
                          
                 <div class="accomplishment-section">
                    <h3>Conferences</h3>
                    <hr/>
                    
<!---<a href="" id='conference_delete_#local.conference.getconferenceid()#'>Delete</a>--->
                     
                     
                    <cfif arrayLen(rc.influencerAccount.getProfile().getconferences())>
                        <div>  
                            <cfloop array="#rc.influencerAccount.getProfile().getconferences()#" index="local.conference">
                                  <table class="accomplishment">  

                                         <tr>
                                            <td class="title">#local.conference.getname()# <a id="conference_edit_#local.conference.getconferenceid()#" class="edit-link" href="##">(edit)</a></td>
                                            <td class="date">#local.conference.getDate()#</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="description">
                                                #local.conference.getDescription()#
                                            </td>
                                        </tr>

                                 </table>

                            </cfloop>
                       </div>
                    <cfelse>
                        <div>No conferences added yet.</div>
                    </cfif>

                    <a id="add-conference" href="##" class="modal-link btn add-item-button">Add Conference</a>
                </div>   
                   


                 <div class="tags-section">
                    <h3>Demographics</h3>
                    <hr/>
                    <ul class="tags-list">
                        <li class="tag">Female</li>
                        <li class="tag">Age 12-16</li>
                        <li class="tag">Age 17-24</li>
                    </ul>
                     <a id="manage-demographics" href="##" class="modal-link btn add-item-button" >Manage Tags</a>
                 </div>

                 <div class="tags-section">
                    <h3>Categories</h3>
                    <hr/>
                    <ul class="tags-list">
                        <li class="tag">Architecture</li>
                        <li class="tag">Cake</li>
                        <li class="tag">Medicine</li>
                        <li class="tag">Forestry</li>
                        <li class="tag">Web Design</li>
                    </ul>
                    <a id="manage-categories" href="##" class="modal-link btn add-item-button" >Manage Categories</a>
                 </div>




            </section>
                        
        
        
        
        
        
        
    </div>
    
    <div id="main-profile-settings" class="col-md-9">
        
        <form action="/index.cfm?action=influencer:main.persistprofile"  role="form" method="post">
		
            <div class="row">

                <div class="col-md-6">

                    <div class="pane">
                        <h2>Your Info</h2>


                        <div class="field">
                            <input id="general_firstname" disabled required pattern=".{1,}" type="text" size="20" name="firstname" value="#rc.influencerAccount.getFirstName()#" />
                            <label for="firstname">First Name</label>
                            <a class="edit-link" href="##">(edit)</a>
                        </div>
                        <div class="field">
                            <input id="general_lastname" disabled type="text" required pattern=".{1,}" size="20" name="lastname" value="#rc.influencerAccount.getLastName()#" />
                            <label for="lastname">Last Name</label>
                            <a class="edit-link" href="##">(edit)</a>
                        </div>
                        
                   
                    <div id="Headshot" class="form-group">
                        <label for="headshotFilename">Headshot Image</label>
                        <input id="headshotFilename" class="form-control" type="file" size="20" name="headshotFilename" value="#rc.influencerAccount.getProfile().getheadshotFilename()#" />
                        <div class="">#rc.influencerAccount.getProfile().getheadshotFilename()#</div>
                    </div>
                    <cfif len(rc.influencerAccount.getProfile().getheadshotFilename())>
                        <img src="/mediaFiles/headshots/#rc.influencerAccount.getProfile().getheadshotFilename()#">
                    </cfif>


                        <h2>Media Template</h2>
                        <div id="general" class="form-group">
                            <label for="mediakitTemplateID">Media Template</label>
                            <select name="mediakitTemplateID" size="1">
                                <option value="1">Headshot Top Left</option>
                            </select>
                        </div>

                   </div>

                </div>

                <div class="col-md-6">

                    <div class="pane">
                        <h2>Presence Info</h2>
                        <div id="general" class="form-group">
                            
                            
                            
                            <div class="field">
                                <input id="blogURL"  disabled required pattern=".{1,}" type="text" size="20" name="blogURL" value="#rc.influencerAccount.getProfile().getblogURL()#" />
                                <label for="blogURL">blogURL</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            <div class="field">
                                <input id="webURL"  disabled required pattern=".{1,}" type="text" size="20" name="webURL" value="#rc.influencerAccount.getProfile().getwebURL()#" />
                                <label for="webURL">webURL</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            
                             <div class="field">
                                <input id="baseInfluenceZipCode" disabled required pattern=".{1,}" type="text" size="20" name="baseInfluenceZipCode" value="#rc.influencerAccount.getProfile().getBaseInfluenceZipCode()#" />
                                <label for="baseInfluenceZipCode">Base Zip Code</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            
                            <div class="field">
                                <input id="BaseInfluencerRadius"  disabled required pattern=".{1,}" type="text" size="20" name="BaseInfluencerRadius" value="#rc.influencerAccount.getProfile().getBaseInfluencerRadius()#" />
                                <label for="BaseInfluencerRadius">Base Radius</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            <div class="field">
                                <textarea  id="keywords" disabled required pattern=".{1,}" name="keywords" cols="40" rows="2">#rc.influencerAccount.getProfile().getkeywords()#</textarea>
                                <label for="keywords">Keywords</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            
                            
                            <div class="field">
                                <textarea  id="description" disabled required pattern=".{1,}" name="description" cols="40" rows="2">#rc.influencerAccount.getProfile().getdescription()#</textarea>
                                <label for="description">Description</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            
                            <div class="field">
                                <input id="BaseInfluencelong"  disabled required pattern=".{1,}" type="text" size="20" name="BaseInfluencelong" value="#rc.influencerAccount.getProfile().getBaseInfluencelong()#" />
                                <label for="BaseInfluencelong">Base Longitude</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            <div class="field">
                                <input id="BaseInfluencelat"  disabled required pattern=".{1,}" type="text" size="20" name="BaseInfluencelat" value="#rc.influencerAccount.getProfile().getBaseInfluencelat()#" />
                                <label for="BaseInfluencelat">Base Longitude</label>
                                <a class="edit-link" href="##">(edit)</a>
                            </div>
                            
                            
                        
                        </div>




                        <button type="submit" class="right" value="Save Registration">Save Profile</button>
                    </div>

            </div>
            </div>
            
        </form>
		
		
	
		
		
		<!---<cfdump var="#rc.influencerAccount.getProfile().getAwards().getBEANARRAY()#" label="cgi" abort="true" top="3" />--->
		
			
            
    </div>
	
</div>
                            
                            <div id="MK-modals">
                
                <div id="add-award_modal" class="MK-modal">
                    <div class="MK-modal_content">
                        <h2 class="MK-modal_header">Add Award</h2>
                        <div class="MK-modal_body">
                            <form action="/index.cfm?action=influencer:award.persistAward" role="form" method="post" enctype="multipart/form-data">

                                <input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />

                                <div class="field">
                                    <input id="name" type="text" required pattern=".{1,}" name="name" value="<cfif structKeyExists(rc,'award')>#rc.award.getName()#</cfif>"/>
                                    <label for="name">Name</label>
                                </div>

                                <div class="field">
                                    <input id="PresentedDate" type="text" required pattern=".{1,}" name="PresentedDate" value="<cfif structKeyExists(rc,'award')>#rc.award.getPresentedDate()#</cfif>" />
                                    <label for="PresentedDate">Presented Date</label>
                                </div>


                                <div class="field">
                                    <input id="PresentedBy" type="text" required pattern=".{1,}" name="PresentedBy" value="<cfif structKeyExists(rc,'award')>#rc.award.getPresentedBy()#</cfif>"/>
                                    <label for="PresentedBy">Presented By</label>
                                </div>

                                <div class="field">
                                    <textarea id="description" type="text" required pattern=".{1,}" name="description"><cfif structKeyExists(rc,'award')>#rc.award.getdescription()#</cfif></textarea>
                                    <label for="description">Description</label>
                                </div>



                                <button type="submit" class="right" value="Save Award">Submit</button>

                            </form>
                        </div>
                    </div>
                </div>

                <div id="add-press-link_modal" class="MK-modal">
                    <div class="MK-modal_content">
                        <h2 class="MK-modal_header">Add Press Link</h2>
                        <div class="MK-modal_body">
                            <form action="/index.cfm?action=influencer:presslink.persistPresslink" role="form" method="post" enctype="multipart/form-data">

                                <input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />

                                <div class="field">
                                    <input id="name" type="text" required pattern=".{1,}" name="name" value="<cfif structKeyExists(rc,'presslink')>#rc.presslink.getName()#</cfif>"/>
                                    <label for="name">Name</label>
                                </div>

                                <div class="field">
                                    <input id="DisplayDate" type="text" required pattern=".{1,}" name="DisplayDate" value="<cfif structKeyExists(rc,'presslink')>#rc.presslink.getDisplayDate()#</cfif>" />
                                    <label for="DisplayDate">Display Date</label>
                                </div>


                                <div class="field">
                                    <input id="Publication" type="text" required pattern=".{1,}" name="Publication" value="<cfif structKeyExists(rc,'presslink')>#rc.presslink.getpublication()#</cfif>"/>
                                    <label for="Publication">Publication</label>
                                </div>

                                <div class="field">
                                    <textarea id="description" type="text" required pattern=".{1,}" name="description"><cfif structKeyExists(rc,'presslink')>#rc.presslink.getdescription()#</cfif></textarea>
                                    <label for="description">Description</label>
                                </div>



                                <button type="submit" class="right" value="Save Press Link">Submit</button>

                            </form>
                        </div>
                    </div>
                </div>	

            <!---<cfdump var="#rc.influencerAccount.getProfile().getconferences().getArray()#" label="cgi" abort="true" top="3" />--->

                <div id="add-conference_modal" class="MK-modal">
                    <div class="MK-modal_content">
                        <h2 class="MK-modal_header">Add Conference</h2>
                        <div class="MK-modal_body">
                            <form action="/index.cfm?action=influencer:conference.persistConference" role="form" method="post" enctype="multipart/form-data">

                                <input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />

                                <div class="field">
                                    <input id="name" type="text" required pattern=".{1,}" name="name" value="<cfif structKeyExists(rc,'conference')>#rc.conference.getName()#</cfif>"/>
                                    <label for="name">Name</label>
                                </div>

                                <div class="field">
                                    <input id="Date" type="text" required pattern=".{1,}" name="Date" value="<cfif structKeyExists(rc,'conference')>#rc.conference.getDate()#</cfif>" />
                                    <label for="Date">Date</label>
                                </div>



                                <div class="field">
                                    <textarea id="description" type="text" required pattern=".{1,}" name="description"><cfif structKeyExists(rc,'conference')>#rc.conference.getdescription()#</cfif></textarea>
                                    <label for="description">Description</label>
                                </div>



                                <button type="submit" class="right" value="Save Award">Submit</button>

                            </form>
                        </div>
                    </div>
                </div>


                <div id="manage-demographics_modal" class="MK-modal">
                    <div class="MK-modal_content">
                        <h2 class="MK-modal_header">Manage Demographics</h2>
                        <div class="MK-modal_body">
                            <form action="/index.cfm?action=influencer:main.persistprofile" role="form" method="post" enctype="multipart/form-data">

                                <input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />
                                <input class="form-control" type="hidden" name="demographics" value="" />

                                <cfloop list="#rc.demographicOptions#" index="local.myDemo" delimiters="^" >
                                    <div class="field">
                                        <input id="demographics_#listFirst(local.myDemo,'|')#"<cfif listFindNoCase(rc.influencerDemos,listFirst(local.myDemo,'|'))>checked=checked </cfif> <!---class="form-control"---> type="checkbox" name="demographics" value="#listFirst(local.myDemo,'|')#" /> #listLast(local.myDemo,'|')#
                                    </div>
                                </cfloop>




                                <button type="submit" class="right" value="Save Demographics">Save</button>

                            </form>
                        </div>
                    </div>
                </div>


                <div id="manage-categories_modal" class="MK-modal">
                    <div class="MK-modal_content">
                        <h2 class="MK-modal_header">Manage Categories</h2>
                        <div class="MK-modal_body">
                            <form action="/index.cfm?action=influencer:main.persistprofile" role="form" method="post" enctype="multipart/form-data">

                                <input type="hidden" name="influenceraccountid" value="#rc.influencerAccount.getID()#" />
                                <input class="form-control" type="hidden" name="categories" value="" />

                                <cfloop list="#rc.categoriesOptions#" index="local.myCat" delimiters="^" >
                                   <div>
                                        <input id="categories_#listFirst(local.myCat,'|')#" <cfif listFindNoCase(rc.influencerCats,listFirst(local.myCat,'|'))>checked=checked </cfif><!---class="form-control"---> type="checkbox" name="categories" value="#listFirst(local.myCat,'|')#" /> #listLast(local.myCat,'|')#
                                   </div>
                                </cfloop>


                                <button type="submit" class="right" value="Save Categories">Save</button>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
		
		
			<div>Silva Web Designs has <span id="twitter-followers"></span> Twitter followers.</div>
			<div class="">https://developers.pinterest.com/docs/api/users/?</div>
			<div class="">https://www.instagram.com/trip.ward/?__a=1</div>
			<div class="">http://web-tricks.co.uk/get-instagram-twitter-followers-count-using-jquery-ajax/</div>
			<div class="">http://web-tricks.co.uk/get-instagram-twitter-followers-count-using-jquery-ajax/</div>

</cfoutput>