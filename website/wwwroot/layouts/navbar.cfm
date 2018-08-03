<cfif rc.title NEQ "Home">
    <cfoutput>
<header>
	<nav role="navigation">
		
			<div class="navbar-brand-wrapper">
				<a class="navbar-brand" href="/">Media_Kits</a>
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar_links">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div><!--- /.navbar-header --->
			<ul class="navbar_links collapse">
				
					
						<li><a href="/?reload=reload">reload all</a></li>
						<li><a href="#buildURL('influencer_subscribe:main.default')#">subscribe</a></li>
						<li><a href="#buildURL('influencer_login:main.default')#">Login</a></li>
						<li><a href="#buildURL('influencer:main.default')#">Profile</a></li>
						<li><a href="#buildURL('influencer:generateMediakit.default')#">Generate Media Kit</a></li>
						<!---#buildURL('influencer:main.default')#
						#buildURL( action = 'influencer:main.default')#
						#buildURL('influencer:main')#--->
						<!---hhh#buildURL( action='product.list' )#--->
<!--
			
					<div class="col-md-3 pull-right">
						<form method="post" id="searchForm" class="navbar-form navbar-right" role="search">
							<div class="input-group">
								<input type="text" name="Keywords" id="navKeywords" class="form-control" value="" placeholder="">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-default">
										<i class="fa fa-search"></i>
									</button>
								</span>
							</div>
							<input type="hidden" name="display" value="search">
							<input type="hidden" name="newSearch" value="true">
							<input type="hidden" name="noCache" value="1">
							
						</form>
					</div>
-->
        </ul>

	</nav><!--- /nav --->
</header>
</cfoutput>
</cfif>