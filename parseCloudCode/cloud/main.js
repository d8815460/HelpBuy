
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

// 排程工作
/*commercial:每日約會數量for ios*/
Parse.Cloud.job("everyday", function(request, status) {
  // Set up to modify user data
  Parse.Cloud.useMasterKey();
  //var counter = 0;
  var query = new Parse.Query(Parse.Installation);

  // Save Expiration - 5 days from now
  var d = new Date();
  var time = (-1 * 24 * 3600 * 1000);
  var expirationDate = new Date(d.getTime() + (time));
  
  // Query Expiration
  var d = new Date();
  var todaysDate = new Date(d.getTime());

  var GameScore = Parse.Object.extend("HelpBuy");
  var query2 = new Parse.Query(GameScore);
  query2.greaterThanOrEqualTo ("createdAt", expirationDate);
  query2.count({
  	success: function(count) {
    	alert("Successfully retrieved " + count + " scores.");
    	// Do something with the returned Parse.Object values
//    	for (var i = 0; i < results.length; i++) {
//      		var object = results[i];
//      		alert(object.id + ' - ' + object.get('playerName'));
//    	}
        var countNum = count;
		Parse.Push.send({
      		where: query,
      		data: {
        		alert: "今日代買資訊新增了" + countNum + "件,你還在等什麼?立即開啟查看!",
        		"p": "a",
        		"t": "commercial",
        		badge: "Increment",
        		"com.parseapp.helpbuy.CUSTOM_BROADCAST": "action"
      		}
    		}, {
      			success: function() {
        		// Push was successful
        		status.success("everyday completed successfully.");
      		},
      			error: function(error) {
        			// Handle error
        			status.error("Uh oh, something went wrong.");
      		}
    	});
		
  	},
  	error: function(error) {
    	alert("Error: " + error.code + " " + error.message);
  	}
  });
});



// Query 送來的物件，是不是已經有重複的，如果有重複先比對時間是否一樣，
// 0.ti沒有重複就儲存，如果title重複就跑
// 1.時間一樣，就不用儲存
// 2.時間不一樣，就覆蓋儲存
Parse.Cloud.define("saveToParse", function(request, response) {
  var query = new Parse.Query("HelpBuy");
  query.equalTo("link", request.params.movie);
  query.descending("ceatedAt");
  query.find({
    success: function(results) {
//	  if (results.get("date") === request.params.postDate){
//	  	response.error("failed");
//	  } else {
	  	response.success(results);
//	  }
    },
    error: function(response) {
	  console.log(response);
      response.error("failed");
    }
  });
});


//追蹤該代買資訊, 要送給雲端包括：1.按鈕是否已經被喜歡了, 2.HelpBuy物件, 3.currentUser當前用戶
//request.params.isSelected 是否已經被喜歡了
//request.params.helpbuy  HelpBuy物件
//request.params.currentUser 當前用戶
//收到回傳之後，要在手機端控制Tabbar的 +1, -1，當減到0的時候就不顯示 badge
//收到回傳之後，要控制Love Button是被選擇的狀態還是沒有被選擇的狀態
parse.Cloud.define("iLoveThisHelpBuy", function(request, response){
	if (request.params.isSelected) {
		var query = new Parse.Query("Love");
		query.equalTo("helpBuy", request.params.helpbuy);
		query.equalTo("user", request.params.currentUser);
		query.first({
			success: function(object) {
				// Successfully retrieved the object.
				object.set("isFollowed", false);
				
				var acl = new Parse.ACL(request.params.currentUser);
				acl.setPublicReadAccess(true);
				acl.setPublicWriteAccess(true);
				object.setACL(acl);
				object.save();
				
				response.success("success:覆蓋舊有資料");
  			},
  			error: function(error) {
	  			var loveObject = Parse.Object.extend("Love");
	  			loveObject.set("helpBuy", request.params.helpbuy);
	  			loveObject.set("user", request.params.currentUser);
	  			loveObject.set("isFollowed", false);
	  				
	  			var acl = new Parse.ACL(request.params.currentUser);
	  			acl.setPublicReadAccess(true);
	  			acl.setPublicWriteAccess(true);
	  			object.setACL(acl);
	  			object.save();
	  				
	  			response.error("failed:沒有資料，新儲存一筆資料");
  				alert("Error: " + error.code + "沒有資料，新儲存一筆資料" + error.message);
  			}
		});
	} else {
		var query = new Parse.Query("Love");
		query.equalTo("helpBuy", request.params.helpbuy);
		query.equalTo("user", request.params.currentUser);
		query.first({
			success: function(object) {
				// Successfully retrieved the object.
				object.set("isFollowed", true);
				
				var acl = new Parse.ACL(request.params.currentUser);
				acl.setPublicReadAccess(true);
				acl.setPublicWriteAccess(true);
				object.setACL(acl);
				object.save();
				
				response.success("success:覆蓋舊有資料");
  			},
  			error: function(error) {
	  			var loveObject = Parse.Object.extend("Love");
	  			loveObject.set("helpBuy", request.params.helpbuy);
	  			loveObject.set("user", request.params.currentUser);
	  			loveObject.set("isFollowed", true);
	  				
	  			var acl = new Parse.ACL(request.params.currentUser);
	  			acl.setPublicReadAccess(true);
	  			acl.setPublicWriteAccess(true);
	  			object.setACL(acl);
	  			object.save();
	  				
	  			response.error("failed:沒有資料，新儲存一筆資料");
  				alert("Error: " + error.code + "沒有資料，新儲存一筆資料" + error.message);
  			}
		});
	}
});

