require("TSLib")
local ts 				= require('ts')
local sz 				= require("sz")
local sqlite3 			= sz.sqlite3	
local json 				= ts.json
local ts_enterprise_lib = require("ts_enterprise_lib")

local model 			= {}

model.wc_bid = ""
model.wc_folder = ""
model.wc_file = ""
model.awz_bid = ""
model.awz_url = ""

model.account = ""
model.password = ""
model.six_two_data = ""

model.infoData = ""
model.word = ""
model.content_num = ""

model.API = "Hk8Ve2Duh6QCR5XUxLpRxPyv"
model.Secret  = "fD0az8pW8lNhGptCZC4TPfMWX5CyVtnh"

model.tab_ENG = {
	language_type = "ENG",
	detect_direction = "true",
	detect_language = "true",
	ocrType = 3
}

model.tab_CHN_ENG = {
	language_type = "CHN_ENG",
	detect_direction = "true",
	detect_language = "true",
	ocrType = 3
}

math.randomseed(getRndNum()) -- 随机种子初始化真随机数

function model:clear_App()
	::run_again::
	mSleep(500)
	closeApp(self.awz_bid) 
	mSleep(math.random(1000, 1500))
	runApp(self.awz_bid)
	mSleep(1000*math.random(1, 3))

	while true do
		--AWZ，AXJ
		mSleep(500)
		flag = isFrontApp(self.awz_bid)
		if flag == 1 then
			if getColor(657,1307) == 0x0950d0 or getColor(652,1198) == 0x0950d0 then
				toast("准备newApp",1)
				break
			end
		else
			goto run_again
		end
	end

	mSleep(1000)
	if getColor(56,1058) == 0x6f7179 then
		mSleep(math.random(500, 1000))
		tap(225,826)
		mSleep(math.random(500, 1000))
		while true do
			if getColor(376, 735) == 0xffffff or getColor(379, 562) == 0xffffff then
				toast("newApp成功",1)
				break
			end
		end
	else
		::new_phone::
		local sz = require("sz");
		local http = require("szocket.http")
		local res, code = http.request(self.awz_url)
		if code == 200 then
			local resJson = sz.json.decode(res)
			local result = resJson.result
			if result == 3 then
				toast("新机成功，但是ip重复了",1)
			elseif result == 1 then
				toast("新机成功",1)
			else 
				toast("失败，请手动查看问题："..tostring(res), 1)
				mSleep(3000)
				goto run_again
			end
		end 
	end
end

function model:TryRemoveUtf8BOM(ret)
	if string.byte(ret,1)==239 and string.byte(ret,2)==187 and string.byte(ret,3)==191 then
		ret=string.char( string.byte(ret,4,string.len(ret)) )
	end
	return ret;
end

function model:_hexStringToFile(hex,file)
	local data = '';
	if hex==nil or string.len(hex)<2 then
		toast('error',1)
		return
	end
	hex = string.match(hex,"(%w+)");
	for i = 1, string.len(hex),2 do
		local code = string.sub(hex, i, i+1);
		data =data..string.char(tonumber(code,16));
	end
	local file = io.open(file, 'wb');
	file:write(data);
	file:close();
end

function model:_writeData(data) --写入62
	local wxdataPath = appDataPath(self.wc_bid) .. self.wc_folder;
	newfolder(wxdataPath)
	os.execute('chown mobile ' .. wxdataPath)
	self:_hexStringToFile(data,appDataPath(self.wc_bid) .. self.wc_file)
	os.execute('chown mobile ' .. appDataPath(self.wc_bid) .. self.wc_file)
end

function model:write_six_two()
	data = self:TryRemoveUtf8BOM(self.infoData)
	if data ~= "" and data ~= nil then
		local data = strSplit(data,"----")
		if #data > 2 then
			self.account = data[1]
			self.password = data[2]
			self.six_two_data = data[3]
		end	
		self:_writeData(self.six_two_data)
		toast("写入成功！") 
		result = true
	else
		dialog("登录失败！原因：写入62数据无效！", 0) 
		result = false
	end	
	return result
end

function model:six_two_login()
	if self:write_six_two() then
		mSleep(2000)
	else
		dialog("登录失败！请检查数据！", 0)
		lua_exit()
	end	
end

function model:clear_data (bid)
	local sz = require("sz")
	local sqlite3 = sz.sqlite3	
	del_sql = function ()
		local db = sqlite3.open("/private/var/Keychains/keychain-2.db")
		db:exec("delete from genp where agrp not like '%apple%'")
		db:exec("delete from cert")
		db:exec("delete from keys")
		db:exec("delete from inet")
		db:exec("delete from sqlite_sequence")
		assert(db:close() == sqlite3.OK)
	end

	delFileEx = function (path)
		os.execute("rm -rf "..path);
	end

	clearCache = function ()
		os.execute("su mobile -c uicache");
	end

	newfolder = function (path)
		os.execute("mkdir "..path);
	end

	if bid == nil or type(bid) ~= "string" then 
		dialog("清理传入的bid有问题") 
		return false 
	end

	toast("清理中,请勿中止",10);
	mSleep(888)
	::getDataPath::
	local dataPath = appDataPath(bid);
	if dataPath == nil then
		goto getDataPath
	end

	local flag = appIsRunning(bid);
	if flag == 1 then
		closeApp(bid); 
		mSleep(1500)
	end

	delFileEx(dataPath.."/Documents") 
	delFileEx(dataPath.."/tmp")
	delFileEx(dataPath.."/Library/APCfgInfo.plist") 
	delFileEx(dataPath.."/Library/APWsjGameConfInfo.plist") 
	delFileEx(dataPath.."/Library/Preferences/*")
	delFileEx(dataPath..self.wc_folder.."*")
	mSleep(500)
	newfolder(dataPath.."/Documents") 
	newfolder(dataPath.."/tmp")
	os.execute("chmod -R 777 ar/Keychains");
	del_sql();
	clearKeyChain(bid);--指定清除应用钥匙串信息Keychains
	--	local str = clearIDFAV();
	--	dialog(str)
	clearCookies();
	toast("清理",2);
	os.execute("chmod -R 777 "..dataPath.."/Documents");
	os.execute("chmod -R 777 "..dataPath.."/tmp");
	os.execute("chmod -R 777 "..dataPath.."/Library");
	os.execute("chmod -R 777 "..dataPath.."/Library/Preferences");
	mSleep(500)
	clearCache();
end

function model:getConfig()
	::read_file::
	tab = readFile(userPath().."/res/config1.txt") 
	if tab then 
		self.wc_bid = string.gsub(tab[1],"%s+","")
		self.wc_folder = string.gsub(tab[2],"%s+","")
		self.wc_file = string.gsub(tab[3],"%s+","")
		self.awz_bid = string.gsub(tab[4],"%s+","")
		self.awz_url = string.gsub(tab[5],"%s+","")
		toast("获取配置信息成功",1)
		mSleep(1000)
	else
		dialog("文件不存在",5)
		goto read_file
	end
end

function model:getList(path) 
	local a = io.popen("ls "..path) 
	local f = {}; 
	for l in a:lines() do 
		table.insert(f,l) 
	end 
	return f 
end 

function model:readFileBase64(path) 
	f = io.open(path,"rb")
	if f == null then
		toast("no file")
		mSleep(3000);
		return null;
	end 
	bytes = f:read("*all");
	f:close();
	return bytes:base64_encode();
end

function model:vpn()
	mSleep(math.random(500, 700))
	setVPNEnable(false)
	setVPNEnable(false)
	setVPNEnable(false)
	mSleep(math.random(500, 700))
	old_data = getNetIP() --获取IP  
	toast(old_data,1)

	::get_vpn::
	mSleep(math.random(200, 500))
	flag = getVPNStatus()
	if flag.active then
		toast("打开状态",1)
		setVPNEnable(false)
		for var= 1, 10 do
			mSleep(math.random(200, 500))
			toast("等待vpn切换"..var,1)
			mSleep(math.random(200, 500))
		end
		goto get_vpn
	else
		toast("关闭状态",1)
	end

	setVPNEnable(true)
	mSleep(1000*math.random(10, 15))

	new_data = getNetIP() --获取IP  
	toast(new_data,1)
	if new_data == old_data then
		toast("vpn切换失败",1)
		mSleep(math.random(200, 500))
		setVPNEnable(false)
		mSleep(math.random(200, 500))
		x,y = findMultiColorInRegionFuzzy( 0x007aff, "3|15|0x007aff,19|10|0x007aff,-50|-128|0x000000,-34|-147|0x000000,3|-127|0x000000,37|-132|0x000000,59|-135|0x000000", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(200, 500))
			randomsTap(x,y,10)
			mSleep(math.random(200, 500))
		end

		--好
		x,y = findMultiColorInRegionFuzzy( 0x007aff, "1|20|0x007aff,11|0|0x007aff,18|17|0x007aff,14|27|0x007aff", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(200, 500))
			randomsTap(x,y,10)
			mSleep(math.random(200, 500))
		end
		goto get_vpn
	else
		toast("vpn正常使用", 1)
	end
end

function model:run()
	mSleep(1000)
	closeApp(self.wc_bid)
	mSleep(2000)

	::getSixData::
	local category = "six-data"
	local plugin_ok,api_ok,data = ts_enterprise_lib:plugin_api_call("DataCenter","get_data",category)
	if plugin_ok and api_ok then
		self.infoData = data
		toast(self.infoData, 1)
		mSleep(1000)
	else
		dialog("62数据获取失败或者数据已经用完，请重新上传新数据:"..tostring(plugin_ok).."----"..tostring(api_ok), 60)
		mSleep(1000)
		goto getSixData
	end

	self:clear_App()
	self:clear_data(self.wc_bid)
	mSleep(2000)
	self:six_two_login()
end

function model:timeOutRestart(t1)
	t2 = ts.ms()

	if os.difftime(t2, t1) > 60 then
		toast("超过45秒退出微信重新进入", 1)
		mSleep(1000)
		closeApp(self.wc_bid)
		mSleep(2000)
		return false
	else
		return true
	end
end

function model:dialog_box()
	mSleep(200)
	x,y = findMultiColorInRegionFuzzy(0x1a1a1a, "5|25|0x1a1a1a,14|7|0x1a1a1a,29|11|0x1a1a1a,45|16|0x1a1a1a,279|16|0x576b95,336|2|0x576b95,359|22|0x576b95,387|16|0x576b95,399|18|0x576b95", 90, 0, 0, 750, 1334, { orient = 2 })
	if x~=-1 and y~=-1 then
		mSleep(math.random(500, 700))
		tap(x, y)
		mSleep(math.random(500, 700))
		toast("忽略",1)
		mSleep(500)
	end

	mSleep(200)
	x,y = findMultiColorInRegionFuzzy( 0x1a1a1a, "321|10|0x576b95,317|-11|0x576b95,39|-356|0x1a1a1a,224|-358|0x1a1a1a,259|-356|0x1a1a1a", 90, 0, 0, 749, 1333)
	if x~=-1 and y~=-1 then
		mSleep(math.random(500, 700))
		tap(x, y)
		mSleep(math.random(500, 700))
		toast("匹配通讯录",1)
		mSleep(500)
	end

	--允许访问位置
	mSleep(200)
	x,y = findMultiColorInRegionFuzzy( 0x007aff, "22|0|0x007aff,38|-1|0x007aff,-114|-273|0x000000,-47|-277|0x000000,-93|-316|0x000000", 90, 0, 0, 749, 1333)
	if x~=-1 and y~=-1 then
		mSleep(math.random(500, 700))
		tap(x, y)
		mSleep(math.random(500, 700))
		toast("允许访问位置",1)
		mSleep(500)
	end

	--好
	mSleep(200)
	x,y = findMultiColorInRegionFuzzy( 0x007aff, "8|-1|0x007aff,6|14|0x007aff,16|-5|0x007aff,27|8|0x007aff,18|22|0x007aff", 90, 0, 0, 749, 1333)
	if x~=-1 and y~=-1 then
		mSleep(math.random(500, 700))
		tap(x, y)
		mSleep(math.random(500, 700))
		toast("好",1)
		mSleep(500)
	end

	--尚未绑定手机号
	mSleep(200)
	x,y = findMultiColorInRegionFuzzy( 0x576b95, "6|-1|0x576b95,33|4|0x576b95,69|3|0x576b95,142|-1|0x576b95,-349|-217|0x1a1a1a,-314|-224|0x1a1a1a,-122|-140|0x1a1a1a,-103|-131|0x1a1a1a,152|-187|0x1a1a1a", 90, 0, 0, 749, 1333)
	if x~=-1 and y~=-1 then
		mSleep(math.random(500, 700))
		tap(x - 250, y)
		mSleep(math.random(500, 700))
		toast("尚未绑定手机号",1)
		mSleep(500)
	end
end

function model:shoucang()
	back = true

	while (true) do
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy(0x1a1a1a, "5|25|0x1a1a1a,14|7|0x1a1a1a,29|11|0x1a1a1a,45|16|0x1a1a1a,279|16|0x576b95,336|2|0x576b95,359|22|0x576b95,387|16|0x576b95,399|18|0x576b95", 90, 0, 0, 750, 1334, { orient = 2 })
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomTap(x,y,4)
			mSleep(math.random(500, 700))
			toast("忽略",1)
			mSleep(500)
		end

		--支付
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x00c777, "-13|-3|0x00c777,24|-2|0x00c777,66|-12|0x1a1a1a,91|-12|0x1a1a1a,79|6|0x1a1a1a,103|2|0x1a1a1a,122|-1|0x1a1a1a", 100, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomTap(x + 200,y + 140,4)
			mSleep(math.random(500, 700))
			toast("收藏",1)
			mSleep(500)
		end

		mSleep(math.random(200, 300))
		if getColor(694, 84) == 0x181818 and getColor(351, 85) == 0x171717 then
			mSleep(500)
			toast("进入收藏",1)
			mSleep(1000)
			category = "error-data"
			data = self.infoData.."----无关键词"

			mSleep(500)
			if getColor(371,  310) ~= 0xa6a6a6 then
			    for var=1,3 do
			        mSleep(4000)
			    end
			    
				local Wildcard = self:getList(appDataPath(self.wc_bid)..self.wc_folder) 
				for var = 1,#Wildcard do 
					local bool = isFileExist(appDataPath(self.wc_bid)..self.wc_folder..Wildcard[var].."/Favorites/fav.db")
					if bool then
						local db = sqlite3.open(appDataPath(self.wc_bid)..self.wc_folder..Wildcard[var].."/Favorites/fav.db")
						local open = db:isopen("fav")
						if open then
							for a in db:nrows('SELECT * FROM FavoritesSearchTable') do
								for k,v in pairs(a) do
									if k == "SearchStr" then
										v = string.gsub(v,"%s+","")
										if processWay == "2" or processWay == "5" then
    										str = string.match(v, '密码:800000ID:')
    										if type(str) ~= "nil" then
    											self.word = string.match(v,".+%d+.+%d+")
    											category = "success-data"
    											data = self.infoData.."----"..self.word
    											toast("识别内容："..self.word,1)
    											mSleep(1000)
    											break
    										end
										elseif processWay == "6" or processWay == "7" then
										    str = string.match(v, '密码:800000ID:')
    										if type(str) ~= "nil" then
    											self.word = string.match(v,".+%d+.+%d+")
    											category = "success-data"
    											data = self.infoData.."----"..self.word
    											toast("识别内容："..self.word,1)
    											mSleep(1000)
    											break
    										else
    										    str = string.match(v, '----%U%d+')
    										    if type(str) ~= "nil" then
    										        data = strSplit(v,";")
        											self.word = data[#data]
        											category = "success-data"
        											data = self.infoData.."----"..self.word
        											toast("识别内容："..self.word,1)
        											mSleep(1000)
        											break
        										end
    										end
									    end
									end
								end
							end
						end
						break
					end
				end
			end
			
			result = {}
			result.category = category
			result.data = data
			return result
		end
	end
end

function model:shibie()
	while (true) do
		mSleep(math.random(200, 300))
		if getColor(267,  276) == 0x000000 and getColor(469,  273) == 0x000000 then
			mSleep(500)
			toast("准备识别",1)
			mSleep(1000)

			::getBaiDuToken::
			local code,access_token = getAccessToken(self.API,self.Secret)
			if code then
				::snap::
				local content_name = userPath() .. "/res/baiduAI_content_name1.jpg"

				--内容
				snapshot(content_name, 406,926,443,964) 
				mSleep(500)

				::put_work::
				header_send = {
					["Content-Type"] = "application/x-www-form-urlencoded",
				}
				body_send = {
					["access_token"] = access_token,
					["image"] = urlEncoder(self:readFileBase64(content_name)),
					["recognize_granularity"] = "big"
				}
				ts.setHttpsTimeOut(60)
				code,header_resp, body_resp = ts.httpsPost("https://aip.baidubce.com/rest/2.0/ocr/v1/numbers", header_send,body_send)
				if code == 200 then
					mSleep(500)
					local tmp = json.decode(body_resp)
					if #tmp.words_result > 0 then
						self.content_num = string.lower(tmp.words_result[1].words)
					else
						mSleep(500)
						local code, body = baiduAI(access_token,content_name,self.tab_ENG)
						if code then
							local tmp = json.decode(body)
							if #tmp.words_result > 0 then
								self.content_num = string.lower(tmp.words_result[1].words)
							else
								toast("识别内容失败\n" .. tostring(body),1)
								mSleep(3000)
								goto snap
							end
						else
							toast("识别内容失败\n" .. tostring(body),1)
							mSleep(3000)
							goto snap
						end       
					end
				else
					toast("识别内容失败\n" .. tostring(body_resp),1)
					mSleep(3000)
					goto put_work
				end 

				if self.content_num ~= nil and #self.content_num >= 1 then
					self.content_num = string.sub(self.content_num,#self.content_num - 1, #self.content_num)
					toast("识别内容：\r\n"..self.content_num,1)
					mSleep(1000)
					category = "success-data"
					data = self.infoData.."----"..self.content_num
				else
					toast("识别内容失败,重新截图识别" .. tostring(body),1)
					mSleep(3000)
					goto snap 
				end
			else
				toast("获取token失败",1)
				goto getBaiDuToken
			end
			result = {}
			result.category = category
			result.data = data
			return result
		end
	end
end

function model:loginAccount(processWay,oldPassword,newPassword)
	::run_app::
	mSleep(1000)
	runApp(self.wc_bid)
	mSleep(2000)
	while (true) do
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x07c160, "171|-1|0x07c160,57|-5|0xffffff,-163|-3|0xf2f2f2,-411|1|0xf2f2f2,-266|-6|0x06ae56", 90, 0, 1100, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			tap(x - 350, y + 20)
			mSleep(math.random(500, 700))
			toast("登录",1)
			mSleep(500)
			break
		end

		mSleep(math.random(200, 300))
		flag = isFrontApp(self.wc_bid)
		if flag == 0 then
			goto run_app
		end
	end

	while (true) do
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "31|-1|0x576b95,55|9|0x576b95,96|0|0x576b95,225|-4|0x576b95,275|7|0x576b95,295|1|0x576b95,329|4|0x576b95", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			tap(x, y)
			mSleep(math.random(500, 700))
			toast("微信号/QQ/邮箱登录",1)
			mSleep(500)
			break
		end
	end

	while (true) do
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "31|-1|0x576b95,55|9|0x576b95,96|0|0x576b95,225|-4|0x576b95,275|7|0x576b95,295|1|0x576b95,329|4|0x576b95", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			tap(x, y)
			mSleep(math.random(500, 700))
		end

		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "33|-4|0x576b95,56|3|0x576b95,72|-4|0x576b95,105|-1|0x576b95,162|3|0x576b95", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			while (true) do
				mSleep(math.random(200, 300))
				x1,y1 = findMultiColorInRegionFuzzy( 0xededed, "-9|0|0xbebebe,10|0|0xbebebe,1|-8|0xbebebe,1|11|0xbebebe,-4|-4|0xededed,5|-4|0xededed,5|5|0xededed,-4|5|0xededed", 90, 647, 0, 749, 648)
				if x1~=-1 and y1~=-1 then
					key = "ReturnOrEnter"
					keyDown(key)
					keyUp(key)
					break
				else
					mSleep(700)
					tap(x + 343, y - 209)
					mSleep(math.random(1500, 1700))
					inputKey(self.account)
					mSleep(500)
				end
			end
			toast("输入账号",1)
			mSleep(500)
			break
		end
	end

	while (true) do
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "33|-4|0x576b95,56|3|0x576b95,72|-4|0x576b95,105|-1|0x576b95,162|3|0x576b95", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			while (true) do
				mSleep(math.random(200, 300))
				x1,y1 = findMultiColorInRegionFuzzy( 0xededed, "-9|0|0xbebebe,10|0|0xbebebe,1|-8|0xbebebe,1|11|0xbebebe,-4|-4|0xededed,5|-4|0xededed,5|5|0xededed,-4|5|0xededed", 90, 647, 0, 749, 648)
				if x1~=-1 and y1~=-1 then
					mSleep(100)
					break
				else
					mSleep(700)
					tap(x + 343, y - 121)
					mSleep(math.random(1500, 1700))
					inputKey(self.password)
					mSleep(500)
				end
			end
			toast("输入密码",1)
			mSleep(500)
			break
		end
	end

	while (true) do
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "35|9|0xffffff,-304|-34|0x07c160,-306|32|0x07c160,1|-38|0x07c160,16|34|0x07c160,334|-35|0x07c160,336|27|0x07c160", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			tap(x, y)
			mSleep(math.random(500, 700))
			toast("登录",1)
			mSleep(500)
			break
		end
	end

	data_six_two = false

	tt = ts.ms()
	while (true) do
		timeOut = self:timeOutRestart(tt)
		if not timeOut then
			tt = ts.ms()
		end

		--登陆
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "35|9|0xffffff,-304|-34|0x07c160,-306|32|0x07c160,1|-38|0x07c160,16|34|0x07c160,334|-35|0x07c160,336|27|0x07c160", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			tap(x, y)
			mSleep(math.random(500, 700))
		end

		self:dialog_box()

		mSleep(math.random(200, 300))
		x, y = findMultiColorInRegionFuzzy(0x7c160,"191|19|0,565|19|0,104|13|0xfafafa,616|24|0xfafafa", 90, 0, 1013, 749,  1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("wc界面",1)
			data_six_two = true
			break
		end

		--绑定手机号码
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x181818, "13|-1|0x181818,27|-1|0x181818,36|-1|0x181818,49|-1|0x181818,63|-1|0x181818,86|-2|0x181818,110|-2|0x181818,130|-2|0x181818", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(1000)
			closeApp(self.wc_bid)
			mSleep(2000)
			toast("绑定手机号码",1)
			mSleep(1000)
		end

		--操作频繁
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy(0x576b95, "12|4|0x576b95,39|1|0x576b95,-93|-175|0x1a1a1a,-94|-163|0x1a1a1a,-84|-167|0x1a1a1a,-73|-167|0x1a1a1a,-14|-175|0x1a1a1a,-7|-166|0x1a1a1a,225|-162|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
		if x ~= -1 then
			mSleep(math.random(500, 700))
			toast("操作频率过快",1)
			mSleep(500)
			category = "caozuo-data"
			data = self.infoData.."----操作频率过快"
			break
		end

		--密码错误
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy(0x576b95, "45|-1|0x576b95,-210|-162|0x1a1a1a,-193|-166|0x1a1a1a,-163|-165|0x1a1a1a,-58|-157|0x1a1a1a,-37|-157|0x1a1a1a,12|-165|0x1a1a1a,66|-160|0x1a1a1a,170|-164|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("密码错误",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----密码错误"
			break
		end

		--连接失败
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "17|0|0x576b95,44|0|0x576b95,-229|-167|0x1a1a1a,-215|-167|0x1a1a1a,-195|-167|0x1a1a1a,-152|-167|0x1a1a1a,-123|-167|0x1a1a1a,198|-168|0x1a1a1a,221|-163|0x1a1a1a", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			tap(x, y)
			mSleep(math.random(500, 700))
			toast("连接失败",1)
			mSleep(500)
			if connect_vpn == "0" then
				self:vpn()
			end
		end

		--外挂封号
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "17|-2|0x576b95,46|-2|0x576b95,-388|-303|0x1a1a1a,-356|-300|0x1a1a1a,-320|-303|0x1a1a1a,-32|-145|0x1a1a1a,3|-139|0x1a1a1a,22|-152|0x1a1a1a,22|-144|0x1a1a1a", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("外挂封号",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----外挂封号"
			break
		end

		--恶意营销
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "28|3|0x576b95,-47|-286|0x1a1a1a,-21|-286|0x1a1a1a,-22|-272|0x1a1a1a,-33|-258|0x1c1c1c,-39|-264|0x1a1a1a,-195|-155|0x1a1a1a,-195|-146|0x1a1a1a,-179|-147|0x1a1a1a", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("恶意营销1",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----恶意营销"
			break
		end

		--恶意营销
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy(0x576b95, "17|-1|0x576b95,44|-2|0x576b95,-184|-151|0x1a1a1a,-165|-155|0x1a1a1a,-165|-150|0x1a1a1a,-173|-140|0x1a1a1a,-143|-148|0x1a1a1a,-131|-149|0x1a1a1a,-124|-148|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("恶意营销2",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----恶意营销"
			break
		end

		--被投诉限制登录
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy(0x576b95, "18|1|0x576b95,45|-2|0x576b95,-323|-183|0x1a1a1a,-310|-188|0x1a1a1a,-305|-184|0x1a1a1a,-279|-184|0x1a1a1a,-355|-261|0x1a1a1a,-319|-262|0x1a1a1a,-82|-138|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("被投诉限制登录",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----被投诉限制登录"
			break
		end
		
		--多人投诉
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy(0x576b95, "17|2|0x576b95,46|0|0x576b95,-7|-142|0x1a1a1a,6|-145|0x1a1a1a,27|-145|0x1a1a1a,69|-142|0x1a1a1a,81|-146|0x1a1a1a,89|-146|0x1a1a1a,-182|-142|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("多人投诉",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----多人投诉"
			break
		end

		--安全验证
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x10aeff, "117|6|0x10aeff,53|1|0xffffff,-265|388|0x1aad19,378|387|0x1aad19,382|440|0x1aad19,-271|449|0x1aad19", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("安全验证1",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----安全验证"
			break
		end
		
		--安全验证
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x10aeff, "28|4|0xffffff,52|8|0x10aeff,105|160|0x191919,-122|784|0x07c160,19|836|0x07c160,199|784|0x07c160,28|784|0x07c160", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("安全验证2",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----安全验证"
			break
		end
		
		--存在异常
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy(0x576b95, "18|-1|0x576b95,45|-2|0x576b95,-145|-262|0x1a1a1a,-133|-276|0x1a1a1a,-131|-260|0x1a1a1a,-98|-266|0x1a1a1a,-67|-278|0x1a1a1a,-32|-260|0x1a1a1a,89|-149|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("存在异常",1)
			data_six_two = false
			category = "error-data"
			data = self.infoData.."----存在异常"
			break
		end
		
		--被盗风险
		mSleep(math.random(200, 300))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "17|1|0x576b95,46|-1|0x576b95,187|-307|0x1a1a1a,203|-325|0x1a1a1a,204|-316|0x1a1a1a,239|-327|0x1a1a1a,221|-307|0x1a1a1a,235|-302|0x1a1a1a,24|-144|0x1a1a1a", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("被盗风险",1)
			data_six_two = false
			category = "caozuo-data"
			data = self.infoData.."----被盗风险"
			break
		end

		mSleep(math.random(200, 300))
		flag = isFrontApp(self.wc_bid)
		if flag == 0 then
			runApp(self.wc_bid)
			mSleep(2000)
		end
	end

	mSleep(500)
	if data_six_two then
		tt = ts.ms()

		while (true) do
			timeOut = self:timeOutRestart(tt)
			if not timeOut then
				tt = ts.ms()
			end

			self:dialog_box()

			mSleep(math.random(200, 300))
			x,y = findMultiColorInRegionFuzzy( 0x07c160, "-4|-26|0x07c160,-569|-17|0xf5f5f5,-54|6|0xf5f5f5", 90, 0, 1190, 749, 1333)
			if x~=-1 and y~=-1 then
				break
			else
				mSleep(math.random(500, 700))
				tap(659, 1269)
				mSleep(math.random(500, 700))
			end

			--绑定手机号码
			mSleep(math.random(200, 300))
			x,y = findMultiColorInRegionFuzzy( 0x181818, "13|0|0x181818,26|0|0x181818,36|0|0x181818,50|0|0x181818,63|0|0x181818,79|-3|0x181818,109|-3|0x181818,129|-3|0x181818,124|-235|0x171717", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(1000)
				closeApp(self.wc_bid)
				mSleep(2000)
				toast("绑定手机号码",1)
				mSleep(1000)
			end
			
			--被盗风险
			mSleep(math.random(200, 300))
			x,y = findMultiColorInRegionFuzzy( 0x576b95, "17|1|0x576b95,46|-1|0x576b95,187|-307|0x1a1a1a,203|-325|0x1a1a1a,204|-316|0x1a1a1a,239|-327|0x1a1a1a,221|-307|0x1a1a1a,235|-302|0x1a1a1a,24|-144|0x1a1a1a", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				toast("被盗风险",1)
				data_six_two = false
				category = "caozuo-data"
				data = self.infoData.."----被盗风险"
				goto pushData
			end
			
			mSleep(math.random(200, 300))
			flag = isFrontApp(self.wc_bid)
			if flag == 0 then
				runApp(self.wc_bid)
				mSleep(2000)
			end
		end

		::networkError::
		if processWay == "0" or processWay == "1" or processWay == "3" or processWay == "4" or processWay == "5" then
			while (true) do
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x1a1a1a, "5|25|0x1a1a1a,14|7|0x1a1a1a,29|11|0x1a1a1a,45|16|0x1a1a1a,279|16|0x576b95,336|2|0x576b95,359|22|0x576b95,387|16|0x576b95,399|18|0x576b95", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(x, y)
					mSleep(math.random(500, 700))
					toast("忽略",1)
					mSleep(500)
				end

				--支付
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0x00c777, "-13|-3|0x00c777,24|-2|0x00c777,66|-12|0x1a1a1a,91|-12|0x1a1a1a,79|6|0x1a1a1a,103|2|0x1a1a1a,122|-1|0x1a1a1a", 100, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(x + 200, y + 20)
					mSleep(math.random(500, 700))
					toast("支付",1)
					mSleep(500)
				end

				if processWay == "4" then
					--三个点:点击收付款
					mSleep(math.random(200, 300))
					x,y = findMultiColorInRegionFuzzy( 0x181818, "-7|-2|0xededed,-14|-2|0x181818,-26|2|0xededed,7|0|0xededed,14|-2|0x181818,30|-2|0xededed,-292|5|0x171717,21|77|0x3cb371,23|319|0x3cb371", 100, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(math.random(500, 700))
						tap(192, 272)
						mSleep(math.random(500, 700))
						toast("收付款",1)
						mSleep(6000)
					end

					--开启刷卡功能
					mSleep(math.random(200, 300))
					x,y = findMultiColorInRegionFuzzy(0x07c160, "-173|-56|0x07c160,-171|-1|0x07c160,1|-57|0x07c160,173|-56|0x07c160,176|1|0x07c160,-7|-98|0xffffff,3|-423|0xb3b3b3,52|-432|0xb3b3b3,-48|-433|0xb3b3b3", 90, 0, 0, 750, 1334, { orient = 2 })
					if x ~= -1 then
						mSleep(math.random(500, 700))
						tap(x, y)
						mSleep(math.random(500, 700))
						toast("开启",1)
						mSleep(1000)
					end

					mSleep(math.random(200, 300))
					if getColor(566,1289) == 0xededed and getColor(617,1280) == 0x181818 then
						mSleep(500)
						break
					end
				else
					--三个点
					mSleep(math.random(200, 300))
					x,y = findMultiColorInRegionFuzzy( 0x181818, "-7|-2|0xededed,-14|-2|0x181818,-26|2|0xededed,7|0|0xededed,14|-2|0x181818,30|-2|0xededed,-292|5|0x171717,21|77|0x3cb371,23|319|0x3cb371", 100, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(math.random(500, 700))
						tap(x, y)
						mSleep(math.random(500, 700))
						toast("三个点",1)
						mSleep(6000)
					end

					--实名认证
					mSleep(math.random(200, 300))
					x,y = findMultiColorInRegionFuzzy(0x171717, "26|12|0x171717,45|8|0x171717,63|12|0x171717,110|9|0x171717,222|120|0x808080,258|106|0x808080,275|106|0x808080,295|110|0x808080,346|109|0x808080", 90, 0, 0, 750, 1334, { orient = 2 })
					if x~=-1 and y~=-1 then
						mSleep(math.random(500, 700))
						toast("未实名",1)
						mSleep(500)
						category = "error-data"
						data = self.infoData.."----未实名"
						goto pushData
					end

					--注销wcPay
					mSleep(math.random(200, 300))
					x,y = findMultiColorInRegionFuzzy( 0x171717, "25|-1|0x171717,11|7|0x171717,37|13|0x171717,57|18|0x171717,82|13|0x171717,106|8|0x171717,123|5|0x171717,173|11|0xededed", 100, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						if processWay == "0" then
							while true do
								mSleep(math.random(200, 300))
								x,y = findMultiColorInRegionFuzzy(0x1b1b1b, "16|11|0x262626,11|22|0x1a1a1a,45|10|0x212121,63|14|0x1a1a1a,97|14|0x1a1a1a,116|14|0x272727,148|-1|0x1a1a1a,168|20|0x1a1a1a,187|8|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
								if x~=-1 and y~=-1 then
									mSleep(math.random(500, 700))
									tap(x, y)
									mSleep(math.random(500, 700))
									toast("注销wcPay",1)
									mSleep(500)
									break
								else
									mSleep(math.random(500, 700))
									moveTowards( 108,  1052, 80, 500)
									mSleep(3000)
								end
							end
						elseif processWay == "1" then
							mSleep(math.random(500, 700))
							tap(414,319)
							mSleep(math.random(500, 700))
						elseif processWay == "3" or processWay == "5" then
							mSleep(math.random(500, 700))
							tap(414,182)
							mSleep(math.random(500, 700))
						end
						break
					end
				end
			end
		end

		if processWay == "0" then
			::again::
			while (true) do
				--确认注销
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0xffffff, "111|-4|0xffffff,-184|-38|0x04be02,-185|31|0x04be02,52|-38|0x04be02,52|31|0x04be02,381|-33|0x04be02,376|27|0x04be02,-36|-607|0x171717,142|-608|0x171717", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(x, y)
					mSleep(math.random(500, 700))
					toast("确认注销",1)
					mSleep(500)
				end

				--验证pay密码
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0xc8c8cd, "-427|-228|0x171717,-270|-222|0x171717,-251|-225|0x171717,-260|-6|0xffffff", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(x - 200, y)
					mSleep(math.random(500, 700))
					toast("验证pay密码",1)
					mSleep(1500)
					break
				end

				--账户冻结
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0xffffff, "25|9|0xffffff,50|10|0xffffff,-293|-16|0x04be02,-298|36|0x04be02,362|-17|0x04be02,355|38|0x04be02,-279|-207|0x000000,-26|-210|0x000000,9|-219|0x000000", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					break
				end

				--原身份已注销
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0xffffff, "30|-4|0xffffff,-228|-34|0x04be02,-230|21|0x04be02,18|-36|0x04be02,15|25|0x04be02,311|-36|0x04be02,312|26|0x04be02,6|-378|0x09bb07,25|-294|0x09bb07", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					toast("检测到原身份已注销",1)
					break
				end
			end

			pass_index = 1
			while true do
				--验证pay密码
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0xc8c8cd, "-427|-228|0x171717,-270|-222|0x171717,-251|-225|0x171717,-260|-6|0xffffff", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(x - 200, y)
					mSleep(math.random(500, 700))
				end

				mSleep(math.random(200, 300))
				if getColor(566,1289) == 0xededed and getColor(617,1280) == 0x181818 then
					oldPasswordArr = strSplit(oldPassword,"-")
					payPass = string.gsub(oldPasswordArr[pass_index],"%s+","")
					mSleep(500)
					for i = 1, #(payPass) do
						mSleep(500)
						num = string.sub(payPass,i,i)
						if num == "0" then
							tap(373, 1281)
						elseif num == "1" then
							tap(132,  955)
						elseif num == "2" then
							tap(377,  944)
						elseif num == "3" then
							tap(634,  941)
						elseif num == "4" then
							tap(128, 1063)
						elseif num == "5" then
							tap(374, 1061)
						elseif num == "6" then
							tap(628, 1055)
						elseif num == "7" then
							tap(119, 1165)
						elseif num == "8" then
							tap(378, 1160)
						elseif num == "9" then
							tap(633, 1164)
						end
						mSleep(100)
					end
				end

				--原身份已注销
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0xffffff, "30|-4|0xffffff,-228|-34|0x04be02,-230|21|0x04be02,18|-36|0x04be02,15|25|0x04be02,311|-36|0x04be02,312|26|0x04be02,6|-378|0x09bb07,25|-294|0x09bb07", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					toast("原身份已注销",1)
					mSleep(500)
					category = "success-data"
					data = self.infoData.."----注销成功"
					break
				end

				--支付密码错误
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x576b95, "12|3|0x576b95,10|17|0x576b95,34|7|0x576b95,50|1|0x576b95,79|12|0x576b95,117|10|0x576b95,-260|-164|0x1a1a1a,-80|-161|0x1a1a1a,41|-157|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					pass_index = pass_index + 1
					toast("pass_index:"..pass_index.."\r\noldPasswordArr:"..#oldPasswordArr,1)
					mSleep(1000)
					if pass_index > #oldPasswordArr then
						mSleep(math.random(500, 700))
						toast("支付密码错误",1)
						mSleep(500)
						category = "error-data"
						data = self.infoData.."----支付密码错误"
						break
					else
						mSleep(math.random(500, 700))
						tap(x - 260, y)
						mSleep(math.random(500, 700))
						while true do
							mSleep(math.random(200, 300))
							if getColor(566,1289) == 0xededed and getColor(617,1280) == 0x181818 then
								break
							else
								mSleep(math.random(500, 700))
								tap(736,689)
								mSleep(math.random(500, 700))
							end
						end
					end
				end

				--账户冻结
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0xffffff, "25|9|0xffffff,50|10|0xffffff,-293|-16|0x04be02,-298|36|0x04be02,362|-17|0x04be02,355|38|0x04be02,-279|-207|0x000000,-26|-210|0x000000,9|-219|0x000000", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					toast("账户冻结",1)
					mSleep(500)
					category = "error-data"
					data = self.infoData.."----账户冻结"
					break
				end

				--网络通信出现问题
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x576b95, "34|-4|0x576b95,80|-2|0x576b95,84|12|0x576b95,110|3|0x576b95,108|-15|0x576b95,-201|-162|0x1a1a1a,-96|-160|0x1a1a1a,226|-163|0x1a1a1a,268|-174|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(x, y)
					mSleep(math.random(500, 700))
					while true do
						mSleep(math.random(200, 300))
						x,y = findMultiColorInRegionFuzzy(0xc8c8cd, "-427|-228|0x171717,-270|-222|0x171717,-251|-225|0x171717,-260|-6|0xffffff", 90, 0, 0, 750, 1334, { orient = 2 })
						if x~=-1 and y~=-1 then
							mSleep(math.random(500, 700))
							tap(57, 85)
							mSleep(math.random(500, 700))
							break
						end
					end
					toast("网络通信出现问题",1)
					mSleep(500)
					goto networkError
				end

				--确定
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0x02bb00, "10|0|0x02bb00,37|0|0x02bb00,-36|-122|0x000000,-25|-121|0x040404,5|-121|0x000000,34|-125|0x000000,61|-126|0x000000", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(x, y)
					mSleep(math.random(500, 700))
					toast("确定",1)
					mSleep(500)
					goto again
				end
			end
		elseif processWay == "1" then
			pass_index = 1
			while true do
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0x171717, "25|-1|0x171717,11|7|0x171717,37|13|0x171717,57|18|0x171717,82|13|0x171717,106|8|0x171717,123|5|0x171717,173|11|0xededed", 100, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					tap(414,319)
					mSleep(math.random(500, 700))
				end

				mSleep(math.random(200, 300))
				if getColor(566,1289) == 0xededed and getColor(617,1280) == 0x181818 then
					if getColor(288,813) == 0x07c160 then
						mSleep(math.random(500, 700))
						tap(288,813)
						mSleep(math.random(500, 700))
						while true do
							mSleep(math.random(200, 300))
							x,y = findMultiColorInRegionFuzzy( 0x171717, "25|-1|0x171717,11|7|0x171717,37|13|0x171717,57|18|0x171717,82|13|0x171717,106|8|0x171717,123|5|0x171717,173|11|0xededed", 100, 0, 0, 749, 1333)
							if x~=-1 and y~=-1 then
								mSleep(500)
								toast("修改支付成功",1)
								mSleep(1000)
								category = "success-data"
								data = self.infoData.."----修改支付成功"
								break
							end

							--账户冻结
							mSleep(math.random(200, 300))
							x,y = findMultiColorInRegionFuzzy(0x576b95, "17|1|0x576b95,45|-2|0x576b95,1|-242|0x1a1a1a,18|-232|0x1a1a1a,10|-221|0x1a1a1a,29|-235|0x1a1a1a,29|-226|0x1a1a1a,47|-237|0x1a1a1a,46|-228|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
							if x ~= -1 then
								mSleep(math.random(500, 700))
								toast("账户冻结",1)
								mSleep(500)
								category = "error-data"
								data = self.infoData.."----账户冻结"
								break
							end

							--账户冻结
							mSleep(math.random(200, 300))
							x,y = findMultiColorInRegionFuzzy(0x5d7199, "17|-2|0x5d7199,44|-3|0x5d7199,3|-243|0x212121,19|-243|0x212121,10|-225|0x212121,40|-243|0x212121,52|-236|0x212121,46|-229|0x212121,52|-220|0x212121", 90, 0, 0, 750, 1334, { orient = 2 })
							if x ~= -1 then
								mSleep(math.random(500, 700))
								toast("账户冻结",1)
								mSleep(500)
								category = "error-data"
								data = self.infoData.."----账户冻结"
								break
							end
						end
						break
					elseif getColor(345,309) == 0x1a1a1a then
						oldPasswordArr = strSplit(oldPassword,"-")
						payPass = string.gsub(oldPasswordArr[pass_index],"%s+","")
					elseif getColor(491,325) == 0x1a1a1a then
						payPass = string.gsub(newPassword,"%s+","")
					end

					mSleep(500)
					for i = 1, #(payPass) do
						mSleep(500)
						num = string.sub(payPass,i,i)
						if num == "0" then
							tap(373, 1281)
						elseif num == "1" then
							tap(132,  955)
						elseif num == "2" then
							tap(377,  944)
						elseif num == "3" then
							tap(634,  941)
						elseif num == "4" then
							tap(128, 1063)
						elseif num == "5" then
							tap(374, 1061)
						elseif num == "6" then
							tap(628, 1055)
						elseif num == "7" then
							tap(119, 1165)
						elseif num == "8" then
							tap(378, 1160)
						elseif num == "9" then
							tap(633, 1164)
						end
						mSleep(100)
					end
				end

				--账户被锁定
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x1a1a1a, "-1|19|0x1a1a1a,10|0|0x1a1a1a,21|7|0x1a1a1a,15|17|0x1a1a1a,34|13|0x1a1a1a,56|15|0x1a1a1a,87|8|0x1a1a1a,115|-2|0x1a1a1a,182|9|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
				if x ~= -1 then
					mSleep(math.random(500, 700))
					toast("账户被锁定",1)
					mSleep(500)
					category = "error-data"
					data = self.infoData.."----账户被锁定"
					break
				end

				--账户冻结
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x576b95, "17|1|0x576b95,45|-2|0x576b95,1|-242|0x1a1a1a,18|-232|0x1a1a1a,10|-221|0x1a1a1a,29|-235|0x1a1a1a,29|-226|0x1a1a1a,47|-237|0x1a1a1a,46|-228|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
				if x ~= -1 then
					mSleep(math.random(500, 700))
					toast("账户冻结",1)
					mSleep(500)
					category = "error-data"
					data = self.infoData.."----账户冻结"
					break
				end

				--账户冻结
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x5d7199, "17|-2|0x5d7199,44|-3|0x5d7199,3|-243|0x212121,19|-243|0x212121,10|-225|0x212121,40|-243|0x212121,52|-236|0x212121,46|-229|0x212121,52|-220|0x212121", 90, 0, 0, 750, 1334, { orient = 2 })
				if x ~= -1 then
					mSleep(math.random(500, 700))
					toast("账户冻结",1)
					mSleep(500)
					category = "error-data"
					data = self.infoData.."----账户冻结"
					break
				end

				--支付密码错误
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x1a1a1a, "24|0|0x1a1a1a,12|7|0x1a1a1a,36|15|0x1a1a1a,55|14|0x1a1a1a,80|18|0x1a1a1a,123|17|0x1a1a1a,219|17|0x1a1a1a,261|9|0x1a1a1a,294|13|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
				if x ~= -1 then
					mSleep(math.random(500, 700))
					toast("支付密码错误",1)
					mSleep(500)
					category = "error-data"
					data = self.infoData.."----支付密码错误"
					break
				end

				--支付密码错误
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x576b95, "12|3|0x576b95,10|17|0x576b95,34|7|0x576b95,50|1|0x576b95,79|12|0x576b95,117|10|0x576b95,-260|-164|0x1a1a1a,-80|-161|0x1a1a1a,41|-157|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					pass_index = pass_index + 1
					toast("pass_index:"..pass_index.."\r\noldPasswordArr:"..#oldPasswordArr,1)
					mSleep(1000)
					if pass_index > #oldPasswordArr then
						mSleep(math.random(500, 700))
						toast("支付密码错误",1)
						mSleep(500)
						category = "error-data"
						data = self.infoData.."----支付密码错误"
						break
					else
						mSleep(math.random(500, 700))
						tap(x - 260, y)
						mSleep(math.random(500, 700))
						while true do
							mSleep(math.random(200, 300))
							if getColor(566,1289) == 0xededed and getColor(617,1280) == 0x181818 then
								break
							else
								mSleep(math.random(500, 700))
								tap(736,689)
								mSleep(math.random(500, 700))
							end
						end
					end
				end
			end
		elseif processWay == "2" or processWay == "6" then
			result = self:shoucang()
			if result then
				category = result.category
				data = result.data
			end
		elseif processWay == "3" then
			result = self:shibie()
			if result then
				category = result.category
				data = result.data
			end
		elseif processWay == "4" then
			pass_index = 1

			while true do
				mSleep(math.random(200, 300))
				if getColor(566,1289) == 0xededed and getColor(617,1280) == 0x181818 then
					oldPasswordArr = strSplit(oldPassword,"-")
					payPass = string.gsub(oldPasswordArr[pass_index],"%s+","")
					for var= 1, 3 do
						mSleep(500)
						tap(566,1289)
						mSleep(500)
					end

					for i = 1, #(payPass) do
						mSleep(200)
						num = string.sub(payPass,i,i)
						mSleep(300)
						if num == "0" then
							tap(373, 1281)
						elseif num == "1" then
							tap(132,  955)
						elseif num == "2" then
							tap(377,  944)
						elseif num == "3" then
							tap(634,  941)
						elseif num == "4" then
							tap(128, 1063)
						elseif num == "5" then
							tap(374, 1061)
						elseif num == "6" then
							tap(628, 1055)
						elseif num == "7" then
							tap(119, 1165)
						elseif num == "8" then
							tap(378, 1160)
						elseif num == "9" then
							tap(633, 1164)
						end
						mSleep(200)
					end
				end

				mSleep(math.random(200, 300))
				if getColor(234,879) == 0x000000 and getColor(335,1145) == 0x39b472 then
					mSleep(500)
					tap(367,1006)
					mSleep(500)
					toast("零钱",1)
					mSleep(1000)
				end

				mSleep(math.random(200, 300))
				if getColor(43,  841) == 0xfbdf66 then
					::getBaiDuToken1::
					local code,access_token = getAccessToken(self.API,self.Secret)
					if code then
						::snap1::

						local content_name = userPath() .. "/res/baiduAI_content_name1.jpg"

						--内容
						snapshot(content_name, 84,  805,370,  882) 
						mSleep(500)

						local code, body = baiduAI(access_token,content_name,self.tab_CHN_ENG)
						if code then
							local tmp = json.decode(body)
							if #tmp.words_result > 0 then
								content_num = string.lower(tmp.words_result[1].words)
							else
								toast("识别内容失败\n" .. tostring(body),1)
								mSleep(3000)
								goto snap1
							end
						else
							toast("识别内容失败\n" .. tostring(body),1)
							mSleep(3000)
							goto snap1
						end

						if content_num ~= nil and #content_num >= 1 then
							toast("识别内容：\r\n"..content_num,1)
							mSleep(1000)
							while (true) do
								mSleep(500)
								if getColor(263,  669) == 0x07c160 or getColor(263,  660) == 0x09c161 then
									mSleep(500)
									tap(229,  664)
									mSleep(1000)
									break
								else
									mSleep(500)
									tap(384,449)
									mSleep(500)
								end
							end
							dialog(content_num, 0)
							mSleep(1000)
						else
							toast("识别内容失败,重新截图识别" .. tostring(body),1)
							mSleep(3000)
							goto snap1
						end
					else
						toast("获取token失败",1)
						goto getBaiDuToken1
					end
				end

				--订单完成
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0x06ae56, "25|0|0x06ae56,13|2|0x06ae56,13|9|0x06ae56,36|6|0x06ae56,49|-2|0x06ae56,203|8|0xf2f2f2,-143|7|0xf2f2f2,35|-22|0xf2f2f2,29|-43|0xffffff", 100, 0, 800, 750, 1334, { orient = 2 })
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					toast("完成",1)
					mSleep(500)
					category = "success-data"
					data = self.infoData.."----支付成功"
					break
				end

				--订单完成
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0x07c160, "25|0|0x07c160,17|9|0x07c160,37|7|0x07c160,52|-2|0x07c160,206|9|0xf2f2f2,-140|2|0xf2f2f2,32|-24|0xf2f2f2,28|-48|0xffffff", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					toast("完成",1)
					mSleep(500)
					category = "success-data"
					data = self.infoData.."----支付成功"
					break
				end

				--被盗风险
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0x576b95, "9|-10|0x576b95,70|3|0x576b95,115|-11|0x576b95,149|-2|0x576b95,186|-9|0x576b95,-237|1|0x1a1a1a,-208|2|0x1a1a1a,49|-149|0x1a1a1a,110|-143|0x1a1a1a", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					toast("被盗风险",1)
					mSleep(500)
					category = "error-data"
					data = self.infoData.."----被盗风险"
					break
				end

				--被盗嫌疑
				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy( 0x576b95, "22|3|0x576b95,52|1|0x576b95,101|1|0x576b95,136|1|0x576b95,197|2|0x576b95,41|-139|0x1a1a1a,101|-139|0x1a1a1a", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					toast("被盗嫌疑",1)
					mSleep(500)
					category = "error-data"
					data = self.infoData.."----被盗嫌疑"
					break
				end

				mSleep(math.random(200, 300))
				x,y = findMultiColorInRegionFuzzy(0x576b95, "18|1|0x576b95,46|1|0x576b95,145|-166|0x1a1a1a,-145|-174|0x1a1a1a,-124|-166|0x1a1a1a,-108|-159|0x1a1a1a,-88|-161|0x1a1a1a,-63|-157|0x1a1a1a,-22|-157|0x1a1a1a", 90, 0, 0, 750, 1334, { orient = 2 })
				if x ~= -1 then
					pass_index = pass_index + 1
					toast("pass_index:"..pass_index.."\r\noldPasswordArr:"..#oldPasswordArr,1)
					mSleep(1000)
					if pass_index > #oldPasswordArr then
						mSleep(math.random(500, 700))
						toast("支付失败",1)
						mSleep(500)
						category = "error-data"
						data = self.infoData.."----支付失败"
						break
					else
						mSleep(math.random(500, 700))
						tap(x, y)
						mSleep(math.random(500, 700))
						while true do
							mSleep(math.random(200, 300))
							if getColor(566,1289) == 0xededed and getColor(617,1280) == 0x181818 then
								break
							else
								mSleep(math.random(500, 700))
								tap(129,675)
								mSleep(math.random(500, 700))
							end
						end
					end
				end
			end
		elseif processWay == "5" or processWay == "7" then
			result = self:shibie()
			if result then
				while true do
					--支付
					mSleep(math.random(200, 300))
					x,y = findMultiColorInRegionFuzzy( 0x00c777, "-13|-3|0x00c777,24|-2|0x00c777,66|-12|0x1a1a1a,91|-12|0x1a1a1a,79|6|0x1a1a1a,103|2|0x1a1a1a,122|-1|0x1a1a1a", 100, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(100)
						break
					else
						mSleep(math.random(500, 700))
						tap(57, 85)
						mSleep(math.random(500, 700))
					end
				end

				result = self:shoucang()
				if result then
					category = "success-data"
					data = self.infoData.."----"..self.word.."----"..self.content_num
				end
			end
		end

		::pushData::
		local plugin_ok,api_ok,data = ts_enterprise_lib:plugin_api_call("DataCenter","insert_data",category,data)
		if plugin_ok and api_ok then
			toast("插入数据成功", 1)
			mSleep(1000)
		else
			toast("插入数据失败，重新插入:"..tostring(plugin_ok).."----"..tostring(api_ok), 1)
			mSleep(1000)
			goto pushData
		end
	else
		::pushData::
		local plugin_ok,api_ok,data = ts_enterprise_lib:plugin_api_call("DataCenter","insert_data",category,data)
		if plugin_ok and api_ok then
			toast("插入数据成功", 1)
			mSleep(1000)
		else
			toast("插入数据失败，重新插入:"..tostring(plugin_ok).."----"..tostring(api_ok), 1)
			mSleep(1000)
			goto pushData
		end
		toast("账号封禁或者账号密码错误了，进行下一个操作",1)
	end
end

function model:main()
	--	local w,h = getScreenSize()
	--	MyTable = {
	--		["style"] = "default",
	--		["width"] = w,
	--		["height"] = h,
	--		["config"] = "save_001.dat",
	--		["timer"] = 100,
	--		views = {
	--			{
	--				["type"] = "Label",
	--				["text"] = "流程脚本",
	--				["size"] = 30,
	--				["align"] = "center",
	--				["color"] = "255,0,0",
	--			},
	--			{
	--				["type"] = "Label",
	--				["text"] = "====================",
	--				["size"] = 20,
	--				["align"] = "center",
	--				["color"] = "255,0,0",
	--			},
	--			{
	--				["type"] = "Label",
	--				["text"] = "选择进入应用后的修改流程",
	--				["size"] = 15,
	--				["align"] = "center",
	--				["color"] = "0,0,255",
	--			},
	--			{
	--				["type"] = "RadioGroup",                    
	--				["list"] = "注销支付功能,修改支付密码",
	--				["select"] = "0",  
	--				["countperline"] = "4",
	--			},
	--			{
	--				["type"] = "Label",
	--				["text"] = "输入原支付密码(多个密码用-隔开，单个就直接输入就可以)",
	--				["size"] = 15,
	--				["align"] = "center",
	--				["color"] = "0,0,255",
	--			},
	--			{
	--				["type"] = "Edit",        
	--				["prompt"] = "请输入您的原支付密码",
	--				["text"] = "默认值",       
	--			},
	--			{
	--				["type"] = "Label",
	--				["text"] = "设置修改支付密码的新密码",
	--				["size"] = 15,
	--				["align"] = "center",
	--				["color"] = "0,0,255",
	--			},
	--			{
	--				["type"] = "Edit",        
	--				["prompt"] = "请输入您要设置的新密码",
	--				["text"] = "默认值",       
	--			},
	--		}
	--	}

	--	local MyJsonString = json.encode(MyTable)

	--	ret, processWay, oldPassword, newPassword = showUI(MyJsonString)
	--	if ret == 0 then
	--		dialog("取消运行脚本", 3)
	--		luaExit()
	--	end

	local m = TSVersions()
	local a = ts.version()
	local tp = getDeviceType()
	if m <= "1.3.3" then
		dialog("请使用 v1.3.3 及其以上版本 TSLib",0)
		lua_exit()
	end

	if  tp >= 0  and tp <= 2 then
		if a <= "1.3.9" then
			dialog("请使用 iOS v1.4.0 及其以上版本 ts.so",0)
			lua_exit()
		end
	elseif  tp >= 3 and tp <= 4 then
		if a <= "1.1.0" then
			dialog("请使用安卓 v1.1.1 及其以上版本 ts.so",0)
			lua_exit()
		end
	end

	if oldPassword == "" or oldPassword == "默认值" then
		dialog("原支付密码不能为空，请重新运行脚本设置支付密码", 0)
		luaExit()
	end

	if processWay == "1" then
		if newPassword == "" or newPassword == "默认值" then
			dialog("当前选择修改支付密码，新密码不能为空，请重新运行脚本设置新密码", 0)
			luaExit()
		end
	end

	while true do
		self:getConfig()
		self:run()
		if connect_vpn == "0" then
			self:vpn()
		else
			mSleep(100)
			setVPNEnable(false)
			setVPNEnable(false)
			mSleep(100)
		end
		self:loginAccount(processWay,oldPassword,newPassword)
		toast('一个流程结束，进行下一个',1)
	end
end

model:main()


