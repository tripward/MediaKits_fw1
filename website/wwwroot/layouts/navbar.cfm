<cfoutput>
<header class="navbar-wrapper">
	<nav class="navbar navbar-inverse navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/">home</a>
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div><!--- /.navbar-header --->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<div class="row">
					<div class="col-md-7" style="color: white;">
						<a href="/index.cfm?action=influencer:main.default&reload=reload">reload all</a>
						<a href="/index.cfm?action=influencer_subscribe:main.subscribeForm">subscribe</a>
						<a href="">Profile</a>
						<a href="">Generate Media Kit</a>
					</div>
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
					</div><!--- /search --->
				</div><!--- /.row --->
			</div><!--- /.navbar-collapse --->
		</div><!--- /.container --->
	</nav><!--- /nav --->
</header>
</cfoutput>
