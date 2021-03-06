--wechat version 7.0.7
require "TSLib"
local ts 				= require('ts')
local json 				= ts.json
local model 				= {}

model.awz_bid 			= "AWZ"
model.wc_bid 			= "com.tencent.xin"
math.randomseed(getRndNum()) -- 随机种子初始化真随机数

--随机字符串
function model:randomStr(str, num)
	local ret =''

	for i = 1, num do
		local rchr = math.random(1, string.len(str))
		ret = ret .. string.sub(str, rchr, rchr)
	end
	return ret
end

--[[随机内容(UTF-8中文字符占3个字符)]]
function model:Rnd_Word(strs,i,Length)
	local ret=""
	local z
	if Length == nil then Length = 1 end
	math.randomseed(tostring(os.time()):reverse():sub(1, 6)+State["随机常量"])  
	math.random(string.len(strs)/Length)
	for i=1, i do
		z=math.random(string.len(strs)/Length)
		ret = ret..string.sub(strs,(z*Length)-(Length-1),(z*Length))
	end
	return(ret)
end

--检测指定文件是否存在
function model:file_exists(file_name)
	local f = io.open(file_name, "r")
	return f ~= nil and f:close()
end

function model:moves()
	mns = 80
	mnm = "0|9|0,0|19|0,0|60|0,0|84|0,84|84|0,84|-1|0,61|-1|0,23|-1|0,23|84|0"

	toast("滑动",1)
	mSleep(math.random(500, 700))
	keepScreen(true)
	mSleep(1000)
	snapshot("test_3.jpg", 33, 503, 711, 892)
	mSleep(500)
	ts.img.binaryzationImg(userPath().."/res/test_3.jpg",mns)
	mSleep(500)
	if self:file_exists(userPath().."/res/tmp.jpg") then
		toast("正在计算",1)
		mSleep(math.random(500, 1000))
		keepScreen(false)
		point = ts.imgFindColor(userPath().."/res/tmp.jpg", 0, mnm, 300, 4, 749, 1333);   
		mSleep(math.random(500, 1000))
		if type(point) == "table"  and #point ~=0  then
			mSleep(500)
			x_len = point[1].x
			toast(x_len,1)
			return x_len
		else
			x_len = 0
			return x_len
		end
	else
		dialog("文件不存在",1)
		mSleep(math.random(1000, 1500))
	end
end

function model:change_vpn()
	mSleep(500)
	runApp("com.liguangming.Shadowrocket")
	while true do
		mSleep(500)
		if getColor(547,101) == 0x2473bd then
			mSleep(500)
			tap(365,670)
			mSleep(2000)
			setVPNEnable(true)
			mSleep(5000)
			runApp(self.wc_bid)
			mSleep(1000)
			break
		end

		mSleep(500)
		if getColor(547,101) == 0x4386c5 then
			mSleep(500)
			tap(365,710)
			mSleep(2000)
			setVPNEnable(true)
			mSleep(5000)
			runApp(self.wc_bid)
			mSleep(1000)
			break
		end
	end
end

function model:change_GNvpn()
	mSleep(500)
	runApp("com.liguangming.Shadowrocket")
	while true do
		mSleep(500)
		if getColor(547,101) == 0x2473bd then
			mSleep(500)
			tap(365,579)
			mSleep(3000)
			runApp(self.wc_bid)
			mSleep(1000)
			break
		end

		mSleep(500)
		if getColor(547,101) == 0x4386c5 then
			mSleep(500)
			tap(365,630)
			mSleep(3000)
			runApp(self.wc_bid)
			mSleep(1000)
			break
		end
	end
end

function model:changeGWIP(ip_country)
	while true do
		mSleep(500)
		list = readFile(userPath().."/res/phone_num.txt")
		toast(list[1],1)
		mSleep(100)
		status_resp, header_resp,body_resp = ts.httpGet("http://refresh.rola-ip.co/?user="..ip_userName..tonumber(list[1]).."&country="..ip_country)
		mSleep(1000)
		if (status_resp==200) then--打开网站成功
			local 返回号=json.decode(body_resp)["Msg"]
			if (返回号=="IP修改成功") then
				mSleep(200)
				toast(body_resp)
				mSleep(1000)
				break
			else
				toast("获取失败"..json.decode(body_resp)["Msg"])
				mSleep(2000)
			end
		else
			toast("打开网站失败等待2秒")
			mSleep(3000)
		end

		if (status_resp==502) then--打开网站失败
			toast("打开网站失败等待3秒")
			mSleep(3000)
		end
	end
end

function model:changeGNIP(place_id,iptimes)
	while true do
		mSleep(500)
		list = readFile(userPath().."/res/phone_num.txt")
		toast(list[1],1)
		mSleep(100)
		status_resp, header_resp,body_resp = ts.httpGet("http://refresh.come-ip.site/refresh?token=4bf88e14&time="..iptimes.."&protocol=socks5&isp=0&user="..ip_userName..tonumber(list[1]).."&province="..place_id)
		mSleep(1000)
		if (status_resp==200) then--打开网站成功
			local 返回号=json.decode(body_resp)["Msg"]
			if (返回号=="成功") then
				mSleep(200)
				toast(body_resp)
				mSleep(1000)
				break
			else
				toast("获取失败"..json.decode(body_resp)["Msg"])
				mSleep(2000)
			end
		else
			toast("打开网站失败等待2秒")
			mSleep(3000)
		end

		if (status_resp==502) then--打开网站失败
			toast("打开网站失败等待3秒")
			mSleep(3000)
		end
	end
end


function model:service_GWvpn()
	mSleep(1000)
	toast("更换国外vpn")
	mSleep(1000)
	r = runApp("com.apple.Preferences");    --运行设置
	mSleep(2000)
	setVPNEnable(false); --关闭VPN
	mSleep(500)
	while true do
		toast("寻找vpn")
		mSleep(2000)
		local tab = {
			"e0000fc0007f8000fe0001fc0003f80007f0000f0000300000000030001f000fe007f001fc00fe007f000fc000e000000000000000000000000fffffffffffffffe0060e0060e0060e0060e0060e0060e0060e0060600e0701c03c3c03ff800ff0001000000000000000000fffffffffffffff7c0001e0000f00007c0001e0000f80003c0001e0000780003c0001f0000700003fffffffffffffff$vpn$414$20$62",
		}
		local index = addTSOcrDictEx(tab)
		x, y = tsFindText(index, "vpn", 0,  447, 722, 1293, "262626 , 272727", 98)
		mSleep(200)
		if x == -1 then 
		else
			mSleep(100)
			tap(x,  y,230) --点击跳辅助成功
		end

		mSleep(200)
		local tab = {
			"01fff01fff003800060000c0001c000180001800018000000000000000ff003ff007ff00f0000e0001c000180001800018000180001c0000e0000f00007ff003ff000ff000000000000000000ff001ff007ff00f0000e0001c000180001800018000180001c0000e0000f00007000030000000000000000000000ffffffffff0003e00018000380007c000fe001cf003870070100e0001c00018000000000000000000007f001ff007ff00f1800c1801c180181801818018180181801c1800e1800798003f8001f80000000000000000180001800018001ffff1ffff1ffff01800018000180000800$国外$427$20$93",
		}
		local index = addTSOcrDictEx(tab)
		x, y = tsFindText(index, "国外", 1,  131, 739, 1092, "262626 , 272727", 98)
		mSleep(200)
		if x == -1 then 
		else
			mSleep(100)
			tap(x,  y,230) --点击跳辅助成功
			mSleep(500)
--			setVPNEnable(true); --打开VPN
--			mSleep(3000)
--			r = runApp("com.tencent.xin");    --运行微信
			mSleep(2500)
			break;
		end
	end
end

function model:service_GNvpn()
	mSleep(1000)
	toast("更换国内vpn")
	mSleep(1000)
	r = runApp("com.apple.Preferences");    --运行设置
	mSleep(2000)
	setVPNEnable(false); --关闭VPN
	mSleep(500)
	while true do
		toast("寻找vpn")
		mSleep(2000)
		local tab = {
			"e0000fc0007f8000fe0001fc0003f80007f0000f0000300000000030001f000fe007f001fc00fe007f000fc000e000000000000000000000000fffffffffffffffe0060e0060e0060e0060e0060e0060e0060e0060600e0701c03c3c03ff800ff0001000000000000000000fffffffffffffff7c0001e0000f00007c0001e0000f80003c0001e0000780003c0001f0000700003fffffffffffffff$vpn$414$20$62",
		}
		local index = addTSOcrDictEx(tab)
		x, y = tsFindText(index, "vpn", 0,  447, 722, 1293, "262626 , 272727", 98)
		mSleep(200)
		if x == -1 then 
		else
			mSleep(100)
			tap(x,  y,230) 
		end

		local tab = {
			"3ffff3ffff300003000030000300003180031830318303183031830318303183031fff31fff31830318303183031833318333183031800300003000030000300003ffff3ffff0000000000000000000000000000000000003fff03fff030000300003000030000300103003030070300f0303c033f87ffe0fffe043070030380301c0300e03007030030300103000030000300003fff03fff$国内$367$20$61",
		}
		local index = addTSOcrDictEx(tab)
		x, y = tsFindText(index, "国内", 1,  131, 739, 1092, "262626 , 272727", 98)
		if x == -1 then 
		else
			mSleep(100)
			tap(x,  y,230) 
			mSleep(1000)
--			setVPNEnable(true); --打开VPN
--			mSleep(3000)
--			r = runApp("com.tencent.xin");    --运行微信
			mSleep(2500)
			break;
		end
	end
end


function model:vpn()
	mSleep(math.random(1000, 1500))
	setVPNEnable(false)
	setVPNEnable(false)
	setVPNEnable(false)
	mSleep(math.random(2000, 2500))
	old_data = getNetIP() --获取IP  
	toast(old_data,1)

	::get_vpn::
	mSleep(math.random(500, 700))
	flag = getVPNStatus()
	if flag.active then
		toast("打开状态",1)
		setVPNEnable(false)
		for var= 1, 10 do
			mSleep(math.random(500, 700))
			toast("等待vpn切换"..var,1)
			mSleep(math.random(500, 700))
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
		mSleep(math.random(500, 700))
		setVPNEnable(false)
		mSleep(math.random(500, 700))
		x,y = findMultiColorInRegionFuzzy( 0x007aff, "3|15|0x007aff,19|10|0x007aff,-50|-128|0x000000,-34|-147|0x000000,3|-127|0x000000,37|-132|0x000000,59|-135|0x000000", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x,y,10)
			mSleep(math.random(500, 700))
			toast("vpn连接失败1",1)
		end

		--好
		mSleep(math.random(500, 700))
		x,y = findMultiColorInRegionFuzzy( 0x007aff, "1|20|0x007aff,11|0|0x007aff,18|17|0x007aff,14|27|0x007aff", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x,y,10)
			mSleep(math.random(500, 700))
			toast("vpn连接失败2",1)
		end
		goto get_vpn
	else
		toast("vpn正常使用", 1)
		return new_data
	end

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

function model:clear_App()
	::run_again::
	mSleep(500)
	closeApp(self.awz_bid) 
	mSleep(math.random(1000, 1500))
	runApp(self.awz_bid)
	mSleep(1000*math.random(3, 6))

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
			toast("新机成功，但是ip重复了",1)
		elseif result == 1 then
			toast("新机成功",1)
		else 
			dialog("失败，请手动查看问题", 0)
		end
	end 
end

function model:get_hkUrl(country_num)
	filepath=appDataPath('com.tencent.xin')..'/Documents/MMappedKV/maycrashcpmap_v2'
	local file = io.open(filepath,'r')
	local text = file:read("*all")
	file:close()
	if text then
		local link='https%3a%2f%2fweixin110.qq.com%2fsecurity%2freadtemplate%3ft%3dsignup%5Fverify%2fw%5Fintro%26regcc%3d'..country_num..'%26regmobile%3d'..text:match('mobile=(%d+)&regid')..'%26regid%3d'..text:match('regid=(%d%p%d+)&scen')..'%26scene%3dget_reg_verify_code%26wechat_real_lang%3dzh_CN'
		return urlDecoder(link)
	else
		toast('文件不存在',1)
	end
end

function model:ewm(login_times,phone_help,skey,tiaoma_bool,fz_bool,fz_type,phone,phone_token,api_change,SMS_country,pid,pay_id,ewm_url,provinceId,tzid,getPhone_key,sumbit_key,codeUrl,messGetTime,messSendTime)
	if fz_type == "0" or fz_type == "7" or fz_type == "9" or fz_type == "10" or fz_type == "11" or fz_type == "12" then
		if fz_type == "0" then
			--下单
			::down_ewm::
			local sz = require("sz");
			local http = require("szocket.http")
			local res, code = http.request("http://api.004461.cn/create.action?url="..ewm_url.."&merchant="..sumbit_key.."&provinceId="..provinceId)
			if code == 200 then
				tmp = json.decode(res)
				if tmp.code == "200" then
					toast(tmp.message, 1)
					order_sn = tmp.data.order_sn
				end
			else
				goto down_ewm
			end
		elseif fz_type == "9" then
			::put_work::
			header_send = {}
			body_send = string.format("userKey=%s&qrCodeUrl=%s&phone=%s&provinceId=%s",sumbit_key,ewm_url,phone,"210000")
			ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
			status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/submit", header_send, body_send, true)
			if status_resp == 200 then
				local tmp = json.decode(body_resp)
				if tmp.success then
					taskId = tmp.obj.orderId
					toast("发布成功,id:"..tmp.obj.orderId,1)
				else
					goto put_work
				end
			else
				goto put_work
			end
		elseif fz_type == "10" then
			list = readFile(userPath().."/res/phone_num.txt")
--			toast(list[1],1)
			::put_work::
			header_send = {}
			body_send = string.format("key=%s&url=%s&tel=%s&area=%s&mark=%s",sumbit_key, hk_url, phone, country_num,list[1])
			ts.setHttpsTimeOut(80)--安卓不支持设置超时时间 
			status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/tj", header_send, body_send, true)
			mSleep(1000)
			if status_resp == 200 then
				mSleep(500)
				local tmp = json.decode(body_resp)
				if tmp.success then
					oId = tmp.data.oId
					toast("二维码辅助发布成功:"..oId,1)
					mSleep(5000)
				else
					mSleep(500)
					toast("发布失败，6秒后重新发布",1)
					mSleep(6000)
					goto put_work
				end
			else
				goto put_work
			end
		elseif fz_type == "11" then
			::put_work::
			header_send = {
				["Content-Type"] = "application/x-www-form-urlencoded",
			}
			body_send = {
				["userKey"] = sumbit_key,
			--	["qrCodeImg"] = urlEncoder("data:image/png;base64,"..readFileBase64(userPath().."/res/222.png")),
				["qrCodeUrl"] = urlEncoder(ewm_url),
				["phone"] = phone,
			}
			ts.setHttpsTimeOut(60)
			code,header_resp, body_resp = ts.httpsPost("http://api.qianxing666.com/api/open-api/orders/submit", header_send,body_send)
			if code == 200 then
				mSleep(500)
				local tmp = json.decode(body_resp)
				if tmp.success then
					orderId = tmp.obj.orderId
					toast("二维码辅助发布成功:"..orderId,1)
					mSleep(5000)
				else
					mSleep(500)
					toast("发布失败，6秒后重新发布",1)
					mSleep(6000)
					goto put_work
				end
			else
				goto put_work
			end
		elseif fz_type == "12" then
			::put_work::
			-- 请求header添加token
			header_send = {token=string.format("%s", sumbit_key)}
			body_send = string.format("qr=%s&phone=%s", ewm_url, phone)
			ts.setHttpsTimeOut(60) -- 安卓不支持设置超时时间
			status_resp, header_resp, result = ts.httpPost("https://pu.xgtask.com/api/task/add", header_send, body_send)
			if status_resp == 200 then
				local tmp = json.decode(result)
				if tmp.code == 200 then
					taskId = tmp.data.taskId
					toast("二维码辅助发布成功:"..taskId,1)
					mSleep(5000)
				else
					mSleep(500)
					toast("发布失败，6秒后重新发布:"..result,1)
					mSleep(6000)
					goto put_work
				end
			else
				goto put_work
			end
		end

		--查询订单状态
		backLogin = false
		::backLogin::
		status_time = 0
		while (true) do
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0x7c160,"282|6|0x7c160,121|9|0xffffff,136|-18|0x7c160,133|39|0x7c160,99|-812|0x7c160,165|-790|0x7c160,128|-792|0xffffff", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				toast("辅助成功",1)
				mSleep(2000)
				if not backLogin then
					if vpn_country == "0" or vpn_country == "1" then
						self:change_vpn()
					elseif vpn_country == "2" or vpn_country == "3" then
						self:service_GWvpn()
						setVPNEnable(true); --打开VPN
						mSleep(3000)
						runApp("com.tencent.xin");    --运行微信
						mSleep(2500)
					end
					backLogin = true
					mSleep(3000)
					goto backLogin
				else
					toast("返回注册按钮页面",1)
					mSleep(2000)
				end
				mSleep(1000)
				randomsTap(373, 1099,10)
				mSleep(math.random(500, 700))
				status = 1
				break
			else
				toast("辅助倒计时:"..status_time,1)
				status_time = status_time + 1
				mSleep(4500)
			end

			mSleep(500)
			x,y = findMultiColorInRegionFuzzy( 0xfa5151, "49|1|0xfa5151,-154|787|0x07c160,180|843|0x07c160,186|795|0x07c160,-130|847|0x07c160", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				setVPNEnable(false)
				toast("系统繁忙，稍后再试",1)
				status = 2
				break
			end

			if status_time > 60 then
				status = 2
				break
			end
		end
	end

	yzm_mess = ""
	restart_time = 0
	get_time = 0
	wait = 0
	mess_time = 0
	gn = true
	yzm_error = false
	::get_code_again::
	if status == 1 or fz_bool or tiaoma_bool or phone_help then
		while true do
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0x353535,"44|23|0x353535,67|20|0x353535,-6|331|0,30|317|0,67|317|0,105|455|0x9ce6bf,486|480|0x9ce6bf", 100, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(1500, 2700))
				if fz_type ~= "3" then
					if vpn_country == "0" or vpn_country == "1" then
						self:change_GNvpn()
					elseif vpn_country == "2" or vpn_country == "3" then
						self:service_GNvpn()
						setVPNEnable(true); --打开VPN
						mSleep(3000)
						runApp("com.tencent.xin");    --运行微信
						mSleep(2500)
					end
				end
				setVPNEnable(false)
				mSleep(5000)
				randomsTap(412, 489,5)
				mSleep(math.random(500, 700))
				toast("接收短信中",1)
				break
			end

			mSleep(math.random(500,700))
			if getColor(390,822) == 0x576b95 and getColor(363,822) == 0x576b95 then
				mSleep(500)
				randomsTap(390,822,5)
				mSleep(500)
				toast("拒收微信登录",1)
				yzm_error = true
				break
			end
		end
	end

	if yzm_error then
		for i = 1, 5 do
			mSleep(500)
			x, y = findMultiColorInRegionFuzzy(0x576b95,"12|-6|0x576b95,-20|-7|0x576b95,-24|-10|0x576b95,-298|-5|0x181819,-306|1|0x181819", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(1000, 1700))
				randomsTap(x, y,5)
				mSleep(math.random(500, 700))
				break
			end
		end
		return false
	else
		if status == 1 or fz_bool or tiaoma_bool or phone_help then
			old_yzm = ""
			aodi_bool = false
			::reset_codes::
			if api_change == "0" then
				while (true) do
					mSleep(math.random(500, 700))
					local sz = require("sz");
					local http = require("szocket.http")
					local res, code = http.request("http://47.104.246.33/onlinesim.php?cmd=getsms&apikey="..getPhone_key.."&tzid="..tzid)
					if code == 200 then
						tmp = json.decode(res)
						if tmp.response == "TZ_NUM_ANSWER" then
							toast(tmp.msg,1)
							yzm_mess = tmp.msg
							break
						else
							wait = wait + 1
							toast("验证码获取失败"..wait,1)
							mSleep(1000)
						end
					else
						wait = wait + 1
						toast("验证码获取失败"..wait,1)
						mSleep(1000)
					end
					--messGetTime,messSendTime
					if wait > tonumber(messGetTime) then
						restart_time = restart_time + 1
						if restart_time > tonumber(messSendTime) then
							status = 2
							--标记订单
							local sz = require("sz");
							local http = require("szocket.http")
							local res, code = http.request("http://api.004461.cn/change.action?url="..ewm_url.."&merchant="..sumbit_key.."&order_sn="..order_sn.."&status="..status)
							if code == 200 then
								tmp = json.decode(res)
								if tmp.code == "200" then
									toast(tmp.message, 1)
									mSleep(3000)
								end
							end
							yzm_mess = ""
							lua_restart()
						else
							mSleep(500)
							if fz_type ~= "3" then
								self:change_vpn()
							end
							mSleep(math.random(2000, 3000))
							randomsTap(372,  749, 3)
							mSleep(math.random(1000, 1500))
							randomsTap(368, 1039,5)
							mSleep(math.random(3000, 5000))
							setVPNEnable(true)
							--setVPNEnable(false)
							wait = 1
							toast("重新获取验证码",1)
							mSleep(2000)
							goto get_code_again
						end
					end
				end
			elseif api_change == "1" then
				while true do
					mSleep(500)
					local sz = require("sz")        --登陆
					local http = require("szocket.http")
					local res, code = http.request("http://simsms.org/priemnik.php?metod=get_sms&country="..SMS_country.."&service=opt67&apikey=Zn8GvDXIzN6iRiJyZIc4tmJS0Ziidv&id="..pay_id)
					if code == 200 then
						tmp = json.decode(res)
						if tmp.response == "1" then
							toast(tmp.sms, 1)
							yzm_mess = tmp.sms
							break
						else
							toast("获取不到验证码"..mess_time,1)
							mess_time = mess_time + 1
							mSleep(30000)
						end
					else
						toast("获取验证码失败，重新获取",1)
						mess_time = mess_time + 1
						mSleep(30000)
					end
					--messGetTime,messSendTime
					if mess_time > tonumber(messGetTime) then
						status = 2
						::black::
						local sz = require("sz")        --登陆
						local http = require("szocket.http")
						local res, code = http.request("http://simsms.org/priemnik.php?metod=ban&service=opt67&apikey=Zn8GvDXIzN6iRiJyZIc4tmJS0Ziidv&id="..pay_id)
						if code == 200 then
							tmp = json.decode(res)
							if tmp.response == "1" then
								toast("手机号码拉黑成功", 1)
							else
								toast("拉黑失败",1)
								goto black
							end
						else
							toast("拉黑失败",1)
							goto black
						end
						yzm_mess = ""
						lua_restart()
					end
				end
			elseif api_change == "2" then
				if aodi_bool then
					::file_bool::
					bool = self:file_exists(userPath().."/res/phone_data.txt")
					if bool then
						phone_data = readFile(userPath().."/res/phone_data.txt")
						toast(phone_data[1],1)
						if type(phone_data[1]) ~= "nil" then
							mobile = phone_data[1]
							toast("号码文件有号码",1)
							::get_phone::
							local sz = require("sz")        --登陆
							local http = require("szocket.http")
							local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=getPhone&token="..phone_token.."&iid="..work_id.."&mobile="..mobile)
							mSleep(500)
							if code == 200 then
								data = strSplit(res, "|")
								if data[1] == "1" then
									telphone = data[5]
									pid = data[2]
								else
									toast("获取手机号码失败，重新获取:"..res,1)
									mSleep(1000)
									goto get_phone
								end
							else
								toast("获取手机号码失败，重新获取:"..res,1)
								mSleep(1000)
								goto get_phone
							end
						end
					else
						toast("文件不存在，创建文件",1)
						writeFileString(userPath().."/res/phone_data.txt","","w",0)
						goto file_bool
					end
				end

				::get_mess::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=getPhoneCode&token="..phone_token.."&pid="..pid)
				mSleep(500)
				if code == 200 then
					data = strSplit(res, "|")
					if data[1] == "1" then
						yzm_mess = data[2]
					elseif data[1] == "0" then
						toast("暂无短信"..get_time,1)
						mSleep(15000)
						get_time = get_time + 1
						--messGetTime,messSendTime
						if get_time > tonumber(messGetTime) then
							restart_time = restart_time + 1
							if restart_time > tonumber(messSendTime) then
								status = 2
								::addblack::
								local sz = require("sz")        --登陆
								local http = require("szocket.http")
								local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=addBlack&token="..phone_token.."&pid="..pid.."&reason="..urlEncoder("获取失败"))
								mSleep(500)
								if code == 200 then
									data = strSplit(res, "|")
									if data[1] == "1" then
										toast("拉黑手机号码",1)
									else
										goto addblack
									end
								end
								yzm_mess = ""
								lua_restart()
							else
								mSleep(500)
								if fz_type ~= "3" then
									self:change_vpn()
								end
								mSleep(math.random(2000, 3000))
								randomsTap(372,  749, 3)
								mSleep(math.random(1000, 1500))
								randomsTap(368, 1039,5)
								mSleep(math.random(3000, 5000))
								setVPNEnable(true)
								--setVPNEnable(false)
								get_time = 1
								toast("重新获取验证码",1)
								mSleep(2000)
								goto get_code_again
							end
						else
							goto get_mess
						end
					end
				else
					toast("获取验证码失败，重新获取",1)
					mSleep(15000)
					get_time = get_time + 1
					goto get_mess
				end
			elseif api_change == "3" then
				::get_mess::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://47.56.103.47/api.php?action=GetCode&token="..tokens.."&pid="..work_id.."&number="..phone)
				mSleep(500)
				if code == 200 then
					data = strSplit(res, ",")
					if data[1] == "ok" then
						yzm_mess = data[2]
					elseif data[1] == "no" then
						toast("暂无短信"..get_time,1)
						mSleep(5000)
						get_time = get_time + 1
						--messGetTime,messSendTime
						if get_time > tonumber(messGetTime) then
							restart_time = restart_time + 1
							if restart_time > tonumber(messSendTime) then
								status = 2
								::addblack::
								local sz = require("sz")        --登陆
								local http = require("szocket.http")
								local res, code = http.request("http://47.56.103.47/api.php?action=AddBlackNumber&token="..tokens.."&pid="..kn_id.."&number="..telphone)
								mSleep(500)
								if code == 200 then
									data = strSplit(res, ",")
									if data[1] == "ok" then
										toast("加黑手机号码",1)
									else
										goto addblack
									end
								end
								yzm_mess = ""
								lua_restart()
							else
								mSleep(500)
								if fz_type ~= "3" then
									self:change_vpn()
								end
								mSleep(math.random(2000, 3000))
								randomsTap(372,  749, 3)
								mSleep(math.random(1000, 1500))
								randomsTap(368, 1039,5)
								mSleep(math.random(3000, 5000))
								setVPNEnable(true)
								--setVPNEnable(false)
								get_time = 1
								toast("重新获取验证码",1)
								mSleep(2000)
								goto get_code_again
							end
						else
							goto get_mess
						end
					else
						toast("请求接口或者参数错误,脚本重新运行",1)
						lua_restart()
					end
				else
					toast("获取验证码失败，重新获取",1)
					mSleep(3000)
					goto get_mess
				end
			elseif api_change == "4" then
				::get_mess::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://129.204.138.57:11223/api/Camel/getmessage?token="..tokens.."&skey="..skey)
				mSleep(500)
				if code == 200 then
					tmp = json.decode(res)
					if tmp.Status == 201 then
						yzm_mess = string.match(tmp.Data.SMS, '%d+%d+%d+%d+%d+%d+')
					elseif tmp.Status == 202 then
						toast("暂无短信"..get_time,1)
						mSleep(5000)
						get_time = get_time + 1
						--messGetTime,messSendTime
						if get_time > tonumber(messGetTime) then
							restart_time = restart_time + 1
							if restart_time > tonumber(messSendTime) then
								status = 2
								::addblack::
								local sz = require("sz")        --登陆
								local http = require("szocket.http")
								local res, code = http.request("http://129.204.138.57:11223/api/Camel/addblack?token="..tokens.."&skey="..skey)
								mSleep(500)
								if code == 200 then
									tmp = json.decode(res)
									if tmp.Status == 200 then
										toast("加黑手机号码",1)
									else
										goto addblack
									end
								end
								yzm_mess = ""
								lua_restart()
							else
								mSleep(500)
								if fz_type ~= "3" then
									self:change_vpn()
								end
								mSleep(math.random(2000, 3000))
								randomsTap(372,  749, 3)
								mSleep(math.random(1000, 1500))
								randomsTap(368, 1039,5)
								mSleep(math.random(3000, 5000))
								setVPNEnable(true)
								--setVPNEnable(false)
								get_time = 1
								toast("重新获取验证码",1)
								mSleep(2000)
								goto get_code_again
							end
						else
							goto get_mess
						end
					else
						toast("请求接口或者参数错误,脚本重新运行",1)
						lua_restart()
					end
				else
					toast("获取验证码失败，重新获取",1)
					mSleep(3000)
					goto get_mess
				end
			elseif api_change == "5" then
				::get_mess::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://www2.smspva.net/out/ext_api/getMsg?name="..username.."&pwd="..user_pass.."&pn="..telphone.."&pid=0006&&serial=2")
				mSleep(500)
				if code == 200 then
					tmp = json.decode(res)
					if tmp.code == 200 then
						yzm_mess = tmp.data
						toast(yzm_mess,1)
					elseif tmp.code == 908 then
						toast("暂未查询到验证码，请稍后再试"..get_time,1)
						mSleep(2000)
						get_time = get_time + 1
						--messGetTime,messSendTime
						if get_time > tonumber(messGetTime) then
							status = 2
							local sz = require("sz")        --登陆
							local http = require("szocket.http")
							local res, code = http.request("http://www2.smspva.net/out/ext_api/passMobile?name="..username.."&pwd="..user_pass.."&pn="..telphone.."&pid=0006&serial=2")
							mSleep(500)
							if code == 200 then
								tmp = json.decode(res)
								if tmp.code == 200 then
									toast("释放号码成功",1)
								end
							end
							yzm_mess = ""
							lua_restart()
						else
							goto get_mess
						end
					elseif tmp.code == 405 then
						dialog("验证码获取失败",5)
						mSleep(2000)
						lua_restart()
					end
				else
					toast("获取手机号码失败，重新获取",1)
					mSleep(3000)
					goto get_mess
				end
			elseif api_change == "6" then
				::get_mess::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://47.104.246.33/api.php?cmd=code&token="..getPhone_key.."&src=tl&app=WeChat&username="..username.."&mobile="..telphone)
				toast(res, 1)
				mSleep(500)
				if code == 200 then
					tmp = json.decode(res)
					if #(tmp.data:atrim()) > 0 then
						yzm_mess = tmp.data
					else
						toast("暂无短信"..get_time,1)
						mSleep(5000)
						get_time = get_time + 1
						--messGetTime,messSendTime
						if get_time > tonumber(messGetTime) then
							restart_time = restart_time + 1
							if restart_time > tonumber(messSendTime) then
								status = 2
								yzm_mess = ""
								lua_restart()
							else
								mSleep(500)
								if fz_type ~= "3" then
									self:change_vpn()
								end
								mSleep(math.random(2000, 3000))
								randomsTap(372,  749, 3)
								mSleep(math.random(1000, 1500))
								randomsTap(368, 1039,5)
								mSleep(math.random(3000, 5000))
								setVPNEnable(true)
								--setVPNEnable(false)
								get_time = 1
								mSleep(2000)
								goto get_code_again
							end
						else
							goto get_mess
						end
					end
				else
					toast("获取验证码失败，重新获取",1)
					mSleep(15000)
					get_time = get_time + 1
					goto get_mess
				end
			elseif api_change == "7" then
				yzm_bool = false
				newstatus = "失败"
				::get_mess::
				local ts = require("ts")
				header_send = {}
				body_send = {}
				ts.setHttpsTimeOut(60) --安卓不支持设置超时时间
				code,header_resp, body_resp = ts.httpsGet(codeUrl:atrim(), header_send,body_send)
				if code == 200 then
					yzm_mess = string.match(body_resp, '%d+%d+%d+%d+%d+%d+')
					if type(yzm_mess) == "nil" then
						toast("获取验证码失败",1)
						mSleep(5000)
						get_time = get_time + 1
						--messGetTime,messSendTime
						if get_time > tonumber(messGetTime) then
							restart_time = restart_time + 1
							if restart_time > tonumber(messSendTime) then
								status = 2
								yzm_mess = ""
								::push::
								mSleep(500)
								local sz = require("sz")        --登陆
								local http = require("szocket.http")
								local res, code = http.request("http://47.104.246.33/phone.php?cmd=poststatus&phone="..phone.."&status="..newstatus)
								mSleep(500)
								if code == 200 then
									if reTxtUtf8(res) == "反馈成功" then
										toast("号码状态标记成功",1)
									else
										goto push
									end
								else
									toast("标记失败，重新标记",1)
									mSleep(3000)
									goto push
								end
								lua_restart()
							else
								mSleep(500)
								if fz_type ~= "3" then
									self:change_vpn()
									setVPNEnable(true)
								end
								mSleep(math.random(2000, 3000))
								randomsTap(372,  749, 3)
								mSleep(math.random(1000, 1500))
								randomsTap(368, 1039,5)
								mSleep(math.random(3000, 5000))
								setVPNEnable(true)
								--setVPNEnable(false)
								get_time = 1
								mSleep(2000)
								goto get_code_again
							end
						else
							goto get_mess
						end
					elseif #yzm_mess == 6 then
						toast(mess_yzm,1)
						yzm_bool = true
						newstatus = "成功"
					else
						toast(code..body_resp,1)
						goto get_mess
					end
				else
					toast(code,0)
					goto get_mess
				end

				if yzm_bool then
					toast(phone..newstatus,1)
					::push::
					mSleep(500)
					local sz = require("sz")        --登陆
					local http = require("szocket.http")
					local res, code = http.request("http://47.104.246.33/phone.php?cmd=poststatus&phone="..phone.."&status="..newstatus)
					toast(res, 1)
					mSleep(500)
					if code == 200 then
						if reTxtUtf8(res) == "反馈成功" then
							toast("号码状态标记成功",1)
						else
							goto push
						end
					else
						toast("标记失败，重新标记",1)
						mSleep(3000)
						goto push
					end
				end
			end

			mSleep(500)
			if #yzm_mess:atrim() > 0 and yzm_mess ~= old_yzm then
				if login_times == "1" then
					if gn and not tiaoma_bool then
						mSleep(2000)
--						self:change_GNvpn()
						mSleep(1000)
						gn = false
					end
				end

				if fz_type ~= "3" then
					self:change_GNvpn()
					setVPNEnable(true)
				end

				while true do
					mSleep(math.random(500, 700))
					x, y = findMultiColorInRegionFuzzy(0x353535,"44|23|0x353535,67|20|0x353535,-6|331|0,30|317|0,67|317|0,105|455|0x9ce6bf,486|480|0x9ce6bf", 100, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(math.random(500, 700))
						randomsTap(590,  472,9)
						mSleep(math.random(1000, 1500))
						break
					end
				end


				for var= 1, 10 do
					mSleep(100)
					keyDown("DeleteOrBackspace")
					mSleep(100)
					keyUp("DeleteOrBackspace")
				end

				for i = 1, #(yzm_mess) do
					mSleep(math.random(500, 700))
					num = string.sub(yzm_mess,i,i)
					if num == "0" then
						randomsTap(373, 1281, 8)
					elseif num == "1" then
						randomsTap(132,  955, 8)
					elseif num == "2" then
						randomsTap(377,  944, 8)
					elseif num == "3" then
						randomsTap(634,  941, 8)
					elseif num == "4" then
						randomsTap(128, 1063, 8)
					elseif num == "5" then
						randomsTap(374, 1061, 8)
					elseif num == "6" then
						randomsTap(628, 1055, 8)
					elseif num == "7" then
						randomsTap(119, 1165, 8)
					elseif num == "8" then
						randomsTap(378, 1160, 8)
					elseif num == "9" then
						randomsTap(633, 1164, 8)
					end
				end
				mSleep(math.random(500, 700))
				randomsTap(546,  623,11)
				mSleep(math.random(500, 700))

				login_error = false
				--检查验证码是否正确
				for var= 1, 10 do
					mSleep(500)
					x,y = findMultiColorInRegionFuzzy( 0x576b95, "-28|-1|0x576b95,-15|-154|0x000000,-137|-163|0x000000,146|-158|0x000000", 90, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(500)
						randomsTap(590,  472,9)
						mSleep(1000)
						for var= 1, 10 do
							mSleep(100)
							keyDown("DeleteOrBackspace")
							mSleep(100)
							keyUp("DeleteOrBackspace")
						end
						mSleep(500)
						randomsTap(x,y,5)
						mSleep(3000)
						mSleep(math.random(1000, 1500))
						randomsTap(372,  749, 3)
						mSleep(math.random(1000, 1500))
						randomsTap(368, 1039,5)
						mSleep(math.random(10000, 15000))
						old_yzm = yzm_mess
						aodi_bool = true
						goto reset_codes
					end

					x,y = findMultiColorInRegionFuzzy( 0x576b95, "-28|3|0x576b95,-136|-177|0x000000,-66|-179|0x000000,54|-175|0x000000,199|-180|0x000000", 90, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(500)
						login_error = true
						toast("注册异常",1)
						break
					end
				end

				if fz_type == "0" then
					--标记订单
					local sz = require("sz");
					local http = require("szocket.http")
					local res, code = http.request("http://api.004461.cn/change.action?url="..ewm_url.."&merchant="..sumbit_key.."&order_sn="..order_sn.."&status="..status)

					if code == 200 then
						tmp = json.decode(res)
						if tmp.code == "200" then
							toast(tmp.message, 1)
							mSleep(3000)
						end
					end
				end

				if login_error then
					return false
				else
					return true
				end
			elseif yzm_mess:atrim() == old_yzm:atrim() then
				mSleep(500)
				toast("验证码一样，重新获取",1)
				mSleep(500)
				if fz_type ~= "3" then
					self:change_vpn()
				end
				mSleep(math.random(2000, 3000))
				randomsTap(372,  749, 3)
				mSleep(math.random(1000, 1500))
				randomsTap(368, 1039,5)
				mSleep(math.random(3000, 5000))
				setVPNEnable(false)
				mSleep(30000)
				goto reset_codes
			else
				return false
			end
		else
			if fz_type == "0" then
				--标记订单
				local sz = require("sz");
				local http = require("szocket.http")
				local res, code = http.request("http://api.004461.cn/change.action?url="..ewm_url.."&merchant="..sumbit_key.."&order_sn="..order_sn.."&status="..status)
				if code == 200 then
					tmp = json.decode(res)
					if tmp.code == "200" then
						toast(tmp.message, 1)
						mSleep(3000)
					end
				end
			elseif fz_type == "9" then
				::push_work::
				header_send = {}
				body_send = string.format("userKey=%s&orderId=%s&status=%s",sumbit_key,taskId,status)
				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					elseif tmp.msg == "已提交任务结果" then
						toast("订单可能未接单退款了："..tmp.msg,1)
						mSleep(2000)
					elseif tmp.code == 1 then
						toast(tmp.msg,1)
						mSleep(2000)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					toast(body_resp,1)
					mSleep(3000)
					goto push_work
				end
			elseif fz_type == "10" then
				::push_work::
				header_send = {}
				body_send = string.format("key=%s&oId=%s&sts=%s",sumbit_key,oId,"fail")
				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/xg", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					elseif tmp.code == "3" or tmp.code == "4" or tmp.code == "5" or tmp.code == "7" or tmp.code == "6" then
						toast(tmp.msg,1)
						mSleep(2000)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					toast(body_resp,1)
					mSleep(3000)
					goto push_work
				end
			elseif fz_type == "11" then
				::push_work::
				header_send = {
					["Content-Type"] = "application/x-www-form-urlencoded",
				}
				body_send = {
					["userKey"] = sumbit_key,
					["orderId"] = orderId,
					["status"] = status,
				}
				ts.setHttpsTimeOut(60)
				code,header_resp, body_resp = ts.httpsPost("http://api.qianxing666.com/api/open-api/orders/mark", header_send,body_send)
				if code == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					toast(body_resp,1)
					mSleep(3000)
					goto push_work
				end
			elseif fz_type == "12" then
				::push_work::
				header_send = {token=string.format("%s", sumbit_key)}
				
				body_send = string.format("taskId=%s&status=%s", taskId, 3)
				ts.setHttpsTimeOut(60) -- 安卓不支持设置超时时间
				code,header_resp, body_resp = ts.httpPost("https://pu.xgtask.com/api/task/status", header_send,body_send)
				if code == 200 then
					mSleep(500)
					local tmp = json.decode(body_resp)
					if tmp.code == 200 then
						toast("标记成功",1)
					elseif tmp.message == "任务已被标记为成功" or tmp.message == "任务已被标记为失败" then
						toast("已经标记过该任务",1)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					goto push_work
				end
			end

			if api_change == "7" then
				::push::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://47.104.246.33/phone.php?cmd=poststatus&phone="..phone.."&status=失败")
				mSleep(500)
				if code == 200 then
					if reTxtUtf8(res) == "反馈成功" then
						toast("号码状态标记成功",1)
					else
						goto push
					end
				else
					toast("标记失败，重新标记",1)
					mSleep(3000)
					goto push
				end
			end
			return false
		end
	end
end

function model:idCard()
--	while true do
--		mSleep(200)
--		toast("等待进入微信..."); 
--		mSleep(200)
--		if isColor(509,  796, 0x007aff) then 
--			mSleep(50)   
--			if isColor(241,  783, 0x007aff) then 
--				mSleep(350)
--				tap(241,  783,350) --点用是否
--				mSleep(500)
--			end
--		end

--		mSleep(50)
--		local tab = {
--			"000001c1861c1861d9861ff861df86dc786fc1fffc1ff3c1ff1c3861cf861ff861fd861c1861c18618180000001ffff1ffff3ffff381c0381c0381c0381c0301c0701ff701ff701c0601c0201c0001800000000000000000000003fff03fff03fff40000e0000f8c007ce001ee000cfff00fff00e7300e7330e7330e7330e7330e7330e7330fff30fff30fff30e0030e003000030000300003ffff3ffff3ffff$新闻$553$20$64",
--		}
--		local index = addTSOcrDictEx(tab)
--		x, y = tsFindText(index, "新闻", 119,   47, 397,  795, "575757 , 585858", 98)
--		mSleep(100)
--		if x == -1 then 
--		else
--			toast("已进入微信界面")
--			mSleep(500)
--			tap(650, 1266,350)--点击我
--			mSleep(150)
--			break; 
--		end

--		mSleep(200)
--		if isColor(85, 1267, 0x07c160) then 
--			mSleep(50)   
--			if isColor(650, 1270, 0x5c5c5c) then 
--				toast("已进入微信界面")
--				mSleep(1500)
--				tap(650, 1266,350)--点击我
--				mSleep(150)
--				break; 
--			end
--		end

--		if isColor(583,   80, 0x07c160) then 
--			mSleep(50)
--			if isColor(70,   78, 0x181818) then 
--				mSleep(150)
--				tap(70,   78,200) --点击取消  应急联系人
--				mSleep(500)
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("支付界面")
--		mSleep(1000)
--		if isColor(583,   80, 0x07c160) then 
--			mSleep(50)
--			if isColor(70,   78, 0x181818) then 
--				mSleep(150)
--				tap(70,   78,200) --点击取消  应急联系人
--				mSleep(500)
--			end
--		end

--		if isColor(655, 1257, 0x07c160) then 
--			mSleep(50)
--			if isColor(51,  470, 0x00c777) then 
--				mSleep(150)
--				tap(51,  470,200) --点击钱包
--				mSleep(500)
--				break;
--			end
--		end

--		if isColor(656, 1258, 0x07c160) then 
--			if isColor(50,  550, 0x00c777) then 
--				mSleep(150)
--				tap(50,  550,200) --点击钱包
--				mSleep(2500)
--				break;
--			end
--		end

--		if isColor(509,  796, 0x007aff) then 
--			mSleep(50)   
--			if isColor(241,  783, 0x007aff) then 
--				mSleep(350)
--				tap(241,  783,350) --点用是否
--				mSleep(500)
--			end
--		end

--		mSleep(200)
--		if isColor(85, 1267, 0x07c160) then 
--			mSleep(50)   
--			if isColor(650, 1270, 0x5c5c5c) then 
--				toast("已进入微信界面")
--				mSleep(1500)
--				tap(650, 1266,350)--点击我
--				mSleep(150)
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("钱包界面")
--		mSleep(1000)
--		if isColor(384,  242, 0x3cb371) then 
--			mSleep(50)
--			if isColor(528,  357, 0x9ed9b8) then 
--				mSleep(150)
--				tap(528,  357,200) --点击钱包零钱
--				mSleep(500)
--				break;
--			end
--		end

--		mSleep(150)
--		if isColor(666,   80, 0x181818) then 
--			if isColor(55,  189, 0xffc302) then 
--				mSleep(150)
--				tap(55,  189,200) --点击钱包零钱
--				mSleep(2500)
--				break;
--			end
--		end

--		mSleep(150)
--		if isColor(655, 1257, 0x07c160) then 
--			mSleep(50)
--			if isColor(51,  470, 0x00c777) then 
--				mSleep(150)
--				tap(51,  470,200) --点击钱包
--				mSleep(500)
--				break;
--			end
--		end

--		mSleep(250)
--		if isColor(656, 1258, 0x07c160) then 
--			if isColor(50,  550, 0x00c777) then 
--				mSleep(150)
--				tap(50,  550,200) --点击钱包
--				mSleep(2500)
--				break;
--			end
--		end

--		mSleep(250)
--		if isColor(370,  168, 0x09bb07) then 
--			if isColor(184,  801, 0x000000) then 
--				mSleep(150)
--				break;
--			end
--		end

--		mSleep(250)
--		if isColor(377,  167, 0x09bb07) then 
--			if isColor(106,  857, 0x888888) then 
--				mSleep(150)
--				break;
--			end
--		end

--		mSleep(250)
--		if isColor(50,  506, 0x1aad19) then --欧盟号
--			if isColor(525, 1146, 0x1aad19) then 
--				mSleep(150)
--				break;
--			end
--		end

--		mSleep(250)
--		if isColor(531, 1074, 0x9ed99d) then 
--			if isColor(493, 1264, 0x586c94) then 
--				mSleep(150)
--				tap(203,  969,200) ----点击我已阅读
--				mSleep(300)
--			end
--		end

--		mSleep(250)
--		if isColor(493, 1264, 0x586c94) then 
--			if isColor(532, 1085, 0x1aad19) then 
--				mSleep(550)
--				tap(532, 1085,200) ----点击我已同意
--				mSleep(3000)
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("认证界面")
--		mSleep(1000)
--		if isColor(50,  506, 0x1aad19) then 
--			if isColor(525, 1146, 0x1aad19) then 
--				mSleep(150)
--				tap(525, 1146,200) ----点击下一步
--				mSleep(500)
--			end
--		end

--		mSleep(250)
--		if isColor(529, 1085, 0x9ed99d) then 
--			if isColor(222,  976, 0x999999) then 
--				mSleep(150)
--				tap(214,  983,200) ----点击我已阅读
--				mSleep(300)
--			end
--		end

--		mSleep(250)
--		if isColor(197,  985, 0x09bb07) then 
--			if isColor(535, 1085, 0x1aad19) then 
--				mSleep(150)
--				tap(526, 1082,200) ----点击我已同意
--				mSleep(3000)
--			end
--		end

--		if isColor(658,  654, 0x9ed99d) then 
--			if isColor(479,  440, 0xb2b2b2) then 
--				mSleep(150)
--				tap(479,  440,350) ----点击填写生日
--				mSleep(3000)
--			end
--		end

--		mSleep(250)
--		if isColor(85,  708, 0x888888) then 
--			if isColor(672,  714, 0x24b023) then 
--				mSleep(1500)
--				tap(672,  714,350) ----点击确定生日
--				mSleep(500)
--			end
--		end

--		if isColor(48,  440, 0x000000) then 
--			if isColor(682,  651, 0x1aad19) then 
--				mSleep(1500)
--				tap(682,  651,350) ----点击下一步
--				mSleep(500)
--			end
--		end

--		if isColor(202,  783, 0x353535) then 
--			if isColor(512,  790, 0x0bb20c) then 
--				mSleep(1500)
--				tap(512,  790,350) ----点击确定生日222
--				mSleep(500)
--			end
--		end

--		mSleep(250)
--		if isColor(55,  185, 0xffc300) then 
--			if isColor(606,  192, 0x191919) then 
--				mSleep(150)
--				tap(606,  192,200) ----点击零钱
--				mSleep(500)
--			end
--		end

--		if isColor(384,  242, 0x3cb371) then 
--			mSleep(50)
--			if isColor(528,  357, 0x9ed9b8) then 
--				mSleep(150)
--				tap(528,  357,200) --点击钱包零钱
--				mSleep(500)
--			end
--		end

--		mSleep(250)
--		if isColor(370,  168, 0x09bb07) then 
--			if isColor(184,  801, 0x000000) then 
--				mSleep(150)
--				tap(184,  801,200) ----点击验证sfz
--				mSleep(500)
--			end
--		end

--		mSleep(250)
--		if isColor(48, 1275, 0x2c2b31) then 
--			if isColor(689, 1275, 0x1aad19) then 
--				mSleep(150)
--				tap(674, 1290,200) ----点击同意
--				mSleep(500)
--				break;
--			end
--		end

--		if isColor(377,  167, 0x09bb07) then 
--			if isColor(106,  857, 0x888888) then 
--				mSleep(1500)
--				tap(106,  857,200) --点击验证大陆
--				mSleep(2500)
--			end
--		end

--		mSleep(250)
--		if isColor(46, 1282, 0x2c2b31) then 
--			if isColor(683, 1275, 0x1aad19) then 
--				mSleep(150)
--				tap(683, 1275,200) --点击同意
--				mSleep(2500)
--				break;
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("认证")
--		mSleep(1000)
--		if isColor(327,  129, 0xc7c7cd) then 
--			if isColor(508,  600, 0x9ce6bf) then 
--				mSleep(1500)
--				tap(298, 1055,200) --输入名
--				mSleep(500)
--				tap(384, 1067,200) --输入名
--				mSleep(1500)
--				tap(345,  205,200) --输入名
--				mSleep(500)
--				tap(345,  205,200) --输入名
--				break;
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("认证1")
--		mSleep(1000)
--		if isColor(345,  206, 0xc7c7cd) then 
--			if isColor(495,  582, 0x9ce6bf) then 
--				mSleep(150)
--				inputText("446133264759635126")
--				mSleep(500)
--			else
--				mSleep(1500)
--				tap(345,  205,200) --输入名
--				mSleep(500)
--			end
--		end

--		mSleep(250)
--		if isColor(700,  207, 0xcccccc) then 
--			if isColor(605,  583, 0x9ce6bf) then 
--				mSleep(150)
--				break
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("选择职业")
--		mSleep(1000)
--		if isColor(700,  207, 0xcccccc) then 
--			if isColor(605,  583, 0x9ce6bf) then 
--				mSleep(150)
--				tap(246,  291,200) --输入职业
--				mSleep(150)
--			end
--		end

--		mSleep(250)
--		if isColor(325,   72, 0x181818) then 
--			if isColor(49,  693, 0x191919) then 
--				mSleep(150)
--				tap(49,  693,200) --输入jinr
--				mSleep(150)
--				break
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("选择地区")
--		mSleep(1000)
--		if isColor(177,  297, 0x000000) then 
--			if isColor(246,  384, 0xc7c7cd) then 
--				mSleep(150)
--				tap(246,  384,200) --请输入地区
--				mSleep(150)
--			end
--		end

--		mSleep(250)
--		if isColor(346,   77, 0x181818) then 
--			if isColor(716,  700, 0xc7c7cc) then 
--				mSleep(150)
--				tap(51,  697,200) --请澳门
--				mSleep(150)
--			end
--		end

--		mSleep(250)
--		if isColor(121,  169, 0x8e8e93) then 
--			if isColor(223,  796, 0x000000) then 
--				mSleep(150)
--				tap(223,  796,200) --地区
--				mSleep(150)
--				break;
--			end
--		end

--		mSleep(250)
--		if isColor(120,  169, 0x8e8e93) then 
--			mSleep(350)
--			tap(81,  358,200) --地区第一个
--			mSleep(1000)
--			break
--		end
--	end

--	while true do
--		mSleep(150)
--		toast("下一步")
--		mSleep(1000)
--		if isColor(321,   87, 0x181818) then 
--			if isColor(554,  582, 0x07c160) then 
--				mSleep(150)
--				tap(554,  582,200) --下一步
--				mSleep(150)
--				break
--			end
--		end

--		mSleep(250)
--		if isColor(184,  803, 0x000000) then 
--			mSleep(150)
--			tap(184,  803,200) --下一步
--			mSleep(150)
--		else
--			mSleep(150)
--			tap(80, 1135,200) --下一步
--			mSleep(1500)
--			tap(80, 1135,200) --下一步
--			mSleep(1500)
--		end

--		if isColor(3148,  346, 0x888888) then 
--			if isColor(46,  780, 0x000000) then 
--				mSleep(150)
--				tap(46,  780,350) --重庆
--				mSleep(2500)
--				mSleep(150)
--				tap(40,  618,350) --长寿
--				mSleep(150)
--			end
--		end
--		mSleep(250)
--	end

--	while true do
--		mSleep(150)
--		toast("密码1")
--		mSleep(300)
--		if isColor(488,  368, 0x040404) then 
--			if isColor(618, 1278, 0x464646) then 
--				密码="11111111"
--				key={
--					["0"]={374, 1281},
--					["1"]={128,  943},
--					["2"]={377,  947},
--					["3"]={623,  945},
--					["4"]={134, 1055},
--					["5"]={366, 1053},
--					["6"]={616, 1056},
--					["7"]={132, 1154},
--					["8"]={370, 1161},
--					["9"]={620, 1163},
--				}
--				function clickstr(ss)
--					for k=1,string.len(ss) do 
--						str=string.sub(ss,k,k)
--						if type(key[str])=="table" then
--							touchDown(key[str][1],key[str][2])
--							mSleep(200)
--							touchUp(key[str][1],key[str][2])
--						end
--					end
--				end
--				clickstr(密码)
--				break;
--			end
--		end
--	end

--	while true do
--		mSleep(150)
--		if isColor(553,  688, 0x9ce6bf) then 
--			if isColor(616, 1280, 0x464646) then 
--				mSleep(150)
--				密码="11111111"
--				key={
--					["0"]={374, 1281},
--					["1"]={128,  943},
--					["2"]={377,  947},
--					["3"]={623,  945},
--					["4"]={134, 1055},
--					["5"]={366, 1053},
--					["6"]={616, 1056},
--					["7"]={132, 1154},
--					["8"]={370, 1161},
--					["9"]={620, 1163},
--				}
--				function clickstr(ss)
--					for k=1,string.len(ss) do 
--						str=string.sub(ss,k,k)
--						if type(key[str])=="table" then
--							touchDown(key[str][1],key[str][2])
--							mSleep(100)
--							touchUp(key[str][1],key[str][2])
--						end
--					end
--				end
--				clickstr(密码)
--			end
--		end

--		mSleep(150)
--		if isColor(550,  695, 0x07c160) then 
--			mSleep(150)
--			tap(550,  695,200) --下一步
--			mSleep(150)
--		end

--		if isColor(362,  770, 0x576b95) then 
--			mSleep(150)
--			tap(362,  77,200) --确定
--			mSleep(150)
--			break;
--		end
--		mSleep(250)
--	end
end

function model:wechat(fz_error_times,iptimes,ip_country,place_id,data_sel,login_times,login_times_set,skey,wc_version,hk_way,fz_key, fz_type, phone, country_num, phone_token, api_change, SMS_country, username, user_pass, work_id, phone_country, country_id,nickName,password,provinceId,getPhone_key, sumbit_key,messGetTime,messSendTime)
	new_bool = false
	ewm_url_bool = false
	serviceError = false
	old = ""
	::run_app::
	mSleep(500)
	closeApp(self.wc_bid)
	::nexts::
	mSleep(math.random(1000, 1500))
	runApp(self.wc_bid)
	mSleep(math.random(1000, 1500))
	if login_times == "0" then
		while (true) do
			mSleep(math.random(500, 700))
			x,y = findMultiColorInRegionFuzzy( 0x07c160, "171|-1|0x07c160,57|-5|0xffffff,-163|-3|0xf2f2f2,-411|1|0xf2f2f2,-266|-6|0x06ae56", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				randomsTap(549, 1240,10)
				mSleep(math.random(500, 700))
				toast("注册",1)
				break
			end

			mSleep(math.random(500, 700))
			flag = isFrontApp(self.wc_bid)
			if flag == 0 then
				goto run_app
			end
		end
	else
		if data_sel[1] == "0" then
			while (true) do
				mSleep(math.random(500, 700))
				x,y = findMultiColorInRegionFuzzy( 0x07c160, "171|-1|0x07c160,57|-5|0xffffff,-163|-3|0xf2f2f2,-411|1|0xf2f2f2,-266|-6|0x06ae56", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 700))
					randomsTap(549, 1240,10)
					mSleep(math.random(500, 700))
					toast("注册",1)
					break
				end

				mSleep(math.random(500, 700))
				flag = isFrontApp(self.wc_bid)
				if flag == 0 then
					goto run_app
				end
			end
		else
			while true do
				mSleep(math.random(500, 700))
				if getColor(561,1265) == 0x576b95 then
					mSleep(math.random(500, 700))
					randomsTap(542,1273,3)
					mSleep(math.random(500, 700))
				end

				if getColor(393,1170) == 0 then
					mSleep(math.random(500, 700))
					randomsTap(393,1170,3)
					mSleep(math.random(500, 700))
					break
				end
			end
		end
	end

	::start::
	while (true) do
		--10系统
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0xf2f2f2,"458|9|0xf2f2f2,291|-94|0x576b95",100,0,0,749,1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			toast("注册页面",1)
			break
		end

		--11系统
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x9ce6bf,"194|0|0xd7f5e5,530|-7|0x9ce6bf,234|-36|0x9ce6bf,229|28|0x9ce6bf",90,0,700,749,1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(200, 500))
			toast("注册页面",1)
			mSleep(1000)
			break
		end

		--点击模态框10
		mSleep(math.random(500, 700))
		x,y = findMultiColorInRegionFuzzy( 0x1a1a1a,"11|2|0x1a1a1a,44|1|0x1a1a1a,79|-1|0x1a1a1a,114|-1|0x1a1a1a,153|3|0x1a1a1a,187|3|0x1a1a1a", 90, 228, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x,y,10)
			mSleep(math.random(500, 700))
		end

		--点击模态框11
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0,"10|7|0,22|7|0,45|4|0,80|3|0,117|3|0,153|8|0,178|8|0", 90, 228, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(367,1042,10)
			mSleep(math.random(500, 700))
		end
	end

	::aodi::
	if api_change == "0" then
		if country_id == "0" then		--乌克兰
			country_num = "380"
		elseif country_id == "1" then		--英国
			country_num = "44"
		elseif country_id == "2" then		--波兰
			country_num = "48"
		end

		::get_phone::
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://47.104.246.33/onlinesim.php?cmd=getphone&apikey="..getPhone_key.."&service=WeChat&country="..country_num)
		if #res > 10 then
			tmp = json.decode(res)
			if tmp.country == country_num then
				tzid = tmp.tzid
				service_phone = tmp.number
				phone_country = tmp.country
			else
				toast("获取不到国家取号，重新取号:"..res,1)
				mSleep(2000)
				goto get_phone
			end
		else
			toast("获取手机号码失败，重新获取",1)
			mSleep(3000)
			goto get_phone
		end

	elseif api_change == "1" then
		::get_phone::
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://simsms.org/priemnik.php?metod=get_number&country="..SMS_country.."&service=opt67&apikey=Zn8GvDXIzN6iRiJyZIc4tmJS0Ziidv")

		if code == 200 then
			tmp = json.decode(res)
			if tmp.response == "1" then
				toast(tmp.number, 1)
				toast(tmp.CountryCode, 1)
				toast(tmp.id, 1)
				pay_id = tmp.id
			else
				toast("获取不到国家取号，重新取号:"..res,1)
				mSleep(30000)
				goto get_phone
			end
		else
			toast("获取手机号码失败，重新获取:"..res,1)
			mSleep(30000)
			goto get_phone
		end
	elseif api_change == "2" then
		::file_bool::
		bool = self:file_exists(userPath().."/res/phone_data.txt")
		if bool then
			phone_data = readFile(userPath().."/res/phone_data.txt")
			toast(phone_data[1],1)
			if type(phone_data[1]) ~= "nil" then
				mobile = phone_data[1]
				toast("号码文件有号码",1)
				::get_phone::
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=getPhone&token="..phone_token.."&iid="..work_id.."&mobile="..mobile)
				mSleep(500)
				if code == 200 then
					data = strSplit(res, "|")
					if data[1] == "1" then
						telphone = data[5]
						pid = data[2]
						goto next_again
					else
						toast("获取手机号码失败，重新获取:"..res,1)
						mSleep(1000)
						goto get_phone
					end
				else
					toast("获取手机号码失败，重新获取:"..res,1)
					mSleep(1000)
					goto get_phone
				end
			else
				::get_phone::
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=getPhone&token="..phone_token.."&iid="..work_id)

				mSleep(500)
				if code == 200 then
					data = strSplit(res, "|")
					if data[1] == "1" then
						telphone = data[5]
						pid = data[2]
						toast(telphone,1)
						if login_times == "0" then
							writeFileString(userPath().."/res/phone_data.txt",telphone,"w",0)
							writeFileString(userPath().."/res/phone_loginTime.txt","0","w",0)
							toast("号码记录成功",1)
						end
					else
						toast("获取手机号码失败，重新获取:"..res,1)
						mSleep(1000)
						goto get_phone
					end
				else
					toast("获取手机号码失败，重新获取:"..res,1)
					mSleep(1000)
					goto get_phone
				end
			end
		else
			toast("文件不存在，创建文件",1)
			writeFileString(userPath().."/res/phone_data.txt","","w",0)
			goto file_bool
		end
	elseif api_change == "3" then
		::get_token::
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://47.56.103.47/api.php?action=Login&user="..username.."&pwd="..user_pass)

		mSleep(500)
		if code == 200 then
			data = strSplit(res, ",")
			if data[1] == "ok" then
				tokens = data[2]
			else
				toast("请求接口或者参数错误,脚本重新运行:"..res,1)
				lua_restart()
			end
		else
			toast("获取token失败，重新获取:"..res,1)
			mSleep(1000)
			goto get_token
		end

		::get_phone::
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://47.56.103.47/api.php?action=GetNumber&token="..tokens.."&pid="..work_id)

		mSleep(500)
		if code == 200 then
			data = strSplit(res, ",")
			if data[1] == "ok" then
				telphone = data[2]
			elseif data[1] == "no" then
				toast("暂无号码",1)
				mSleep(1000)
				goto get_phone
			else
				toast("请求接口或者参数错误，脚本重新运行:"..res,1)
				lua_restart()
			end
		else
			toast("获取手机号码失败，重新获取:"..res,1)
			mSleep(1000)
			goto get_phone
		end

	elseif api_change == "4" then
		::get_token::
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://129.204.138.57:11223/api/Camel/login?uname="..username.."&upwd="..user_pass)

		mSleep(500)
		if code == 200 then
			tmp = json.decode(res)
			if tmp.Status == 200 then
				tokens = tmp.Data.TOKEN
			else
				toast("请求接口或者参数错误,脚本重新运行:"..tmp.Msg,1)
				lua_restart()
			end
		else
			toast("获取token失败，重新获取:"..res,1)
			mSleep(1000)
			goto get_token
		end

		::get_phone::
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://129.204.138.57:11223/api/Camel/getphone?token="..tokens.."&rid="..work_id.."&idn="..SMS_country)

		mSleep(500)
		if code == 200 then
			tmp = json.decode(res)
			if tmp.Status == 200 then
				telphone = tmp.Data[1].PN
				skey = tmp.Data[1].SKEY
			elseif tmp.Status == 906 then
				toast(tmp.Msg,1)
				mSleep(5000)
				goto get_phone
			else
				toast("请求接口或者参数错误，脚本重新运行:"..tmp.Msg,1)
				lua_restart()
			end
		else
			toast("获取手机号码失败，重新获取:"..res,1)
			mSleep(1000)
			goto get_phone
		end
	elseif api_change == "5" then
		::get_phone::
		mSleep(500)
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://www2.smspva.net/out/ext_api/getMobile?name="..username.."&pwd="..user_pass.."&cuy="..SMS_country.."&pid=0006&num=1&noblack=0&serial=2&secret_key=bfcd1412722c6fc2007bdd4a")
		mSleep(500)
		if code == 200 then
			tmp = json.decode(res)
			if tmp.code == 200 then
				telphone = tmp.data
				toast(telphone,1)
			elseif tmp.code == 906 then
				toast(tmp.msg,1)
				mSleep(5000)
				goto get_phone
			else
				toast(tmp.msg,1)
				mSleep(5000)
				goto get_phone
			end
		else
			toast("获取手机号码失败，重新获取:"..res,1)
			mSleep(3000)
			goto get_phone
		end
	elseif api_change == "6" then
		::file_bool::
		bool = self:file_exists(userPath().."/res/phone_data.txt")
		if bool then
			phone_data = readFile(userPath().."/res/phone_data.txt")
			toast(phone_data[1],1)
			if type(phone_data[1]) ~= "nil" then
				telphone = phone_data[1]
				toast("号码文件有号码",1)
			else
				::get_user::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://47.104.246.33/api.php?cmd=balance&token="..getPhone_key.."&username="..username)
				mSleep(500)
				if code == 200 then
					tmp = json.decode(res)
					if tmp.msg == "success" then
						mSleep(200)
						if tonumber(tmp.data) > 0 then
							toast("当前余额:"..tmp.data,1)
							mSleep(2000)
						else
							toast("当前余额不足",1)
							mSleep(3000)
							goto get_user
						end
					else
						mSleep(500)
						toast("获取信息失败，重新获取:"..res,1)
						mSleep(5000)
						goto get_user
					end
				else
					toast("获取信息失败，重新获取",1)
					mSleep(10000)
					goto get_user
				end

				::get_phone::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://47.104.246.33/api.php?cmd=mobile&token="..getPhone_key.."&src=tl&app=WeChat&username="..username)
				mSleep(500)
				if code == 200 then
					tmp = json.decode(res)
					if tmp.msg == "success" then
						mSleep(200)
						telphone = tmp.data
						toast(telphone,1)
						if login_times == "0" then
							writeFileString(userPath().."/res/phone_data.txt",telphone,"w",0)
							writeFileString(userPath().."/res/phone_loginTime.txt","0","w",0)
							toast("号码记录成功",1)
						end
					else
						mSleep(500)
						toast("获取手机号码失败，重新获取",1)
						mSleep(5000)
						goto get_phone
					end
				else
					toast("获取手机号码失败，重新获取",1)
					mSleep(10000)
					goto get_phone
				end
			end
		else
			toast("文件不存在，创建文件",1)
			writeFileString(userPath().."/res/phone_data.txt","","w",0)
			goto file_bool
		end

	elseif api_change == "7" then
		::file_bool::
		bool = self:file_exists(userPath().."/res/phone_data.txt")
		if bool then
			phone_data = readFile(userPath().."/res/phone_data.txt")
			toast(phone_data[1],1)
			if type(phone_data[1]) ~= "nil" then
				phoneData = strSplit(phone_data[1], "|")
				telphone = phoneData[1]
				codeUrl = phoneData[2]
				toast("号码文件有号码",1)
			else
				::get_phone::
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://47.104.246.33/phone.php?cmd=getphone")
				nLog(res)
				if code == 200 then
					tmp = strSplit(res, "|")
					if #tmp == 2 then
						telphone = tmp[1]
						codeUrl = tmp[2]
						if login_times == "0" then
							writeFileString(userPath().."/res/phone_data.txt",res,"w",0)
							writeFileString(userPath().."/res/phone_loginTime.txt","0","w",0)
							toast("号码记录成功",1)
						end
					else
						toast("获取不到国家取号，重新取号:"..res,1)
						mSleep(30000)
						goto get_phone
					end
				else
					toast("获取手机号码失败，重新获取:"..res,1)
					mSleep(5000)
					goto get_phone
				end
			end
		else
			toast("文件不存在，创建文件",1)
			writeFileString(userPath().."/res/phone_data.txt","","w",0)
			goto file_bool
		end
	end

	if country_id == "0" then
		--昵称
		while true do
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0,"7|2|0,20|-2|0,22|-9|0,40|15|0,55|3|0,58|-5|0", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(500)
				tap(x+300,y+3)
				mSleep(math.random(500, 700))
				break
			end
		end

		if nickName == "0" then  --英文
			for var= 1, 8 do
				num = math.random(1, 26) 
				mSleep(math.random(500, 700))
				if num > 0 and num < 11 then
					randomsTap(37+(num-1)*80,  967,8)
				elseif num > 10 and num < 20 then
					randomsTap(73+(num-11)*80, 1073,8)
				elseif num > 19 and num < 27 then
					randomsTap(147+(num-20)*80, 1179,8)
				end
				mSleep(math.random(500, 700))
			end
		elseif nickName == "1" then  --特殊符号
			mSleep(math.random(500, 700))
--			inputStr("르㸏مฬ้๊سمرًς.έل")
			inputStr("@")
		end
	end

	--国家／地区
	while (true) do
		--10
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x1a1a1a,"22|0|0x1a1a1a,27|27|0x1a1a1a,0|24|0x1a1a1a,14|12|0x1a1a1a,36|5|0x1a1a1a,64|4|0x1a1a1a", 90, 0, 0, 749, 431)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x+60,y+90, 6)
			mSleep(math.random(500, 700))
			break
		end
		--11
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0,"27|26|0,3|25|0,17|-2|0,14|6|0,35|2|0,63|1|0", 90, 0, 0, 749, 701)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x+60,y+90, 6)
			mSleep(math.random(500, 700))
			break
		end
	end


	--删除区号
	for var= 1, 10 do
		mSleep(100)
		keyDown("DeleteOrBackspace")
		mSleep(100)
		keyUp("DeleteOrBackspace")
	end

	--输入国家区号
	mSleep(math.random(500, 700))
	if api_change == "0" then
		country_num = phone_country
	elseif api_change == "1" then
		country_num = tmp.CountryCode
	elseif api_change == "2" or api_change == "3" or api_change == "4" or api_change == "5" or api_change == "6" then
		country_num = phone_country
	elseif api_change == "7" then
		country_num = phone_country
	end
	
	mSleep(math.random(500, 700))
	for i = 1, #(country_num) do
		mSleep(math.random(500, 700))
		num = string.sub(country_num,i,i)
		if num == "0" then
			randomsTap(373, 1281, 8)
		elseif num == "1" then
			randomsTap(132,  955, 8)
		elseif num == "2" then
			randomsTap(377,  944, 8)
		elseif num == "3" then
			randomsTap(634,  941, 8)
		elseif num == "4" then
			randomsTap(128, 1063, 8)
		elseif num == "5" then
			randomsTap(374, 1061, 8)
		elseif num == "6" then
			randomsTap(628, 1055, 8)
		elseif num == "7" then
			randomsTap(119, 1165, 8)
		elseif num == "8" then
			randomsTap(378, 1160, 8)
		elseif num == "9" then
			randomsTap(633, 1164, 8)
		end
	end

	--密码
	while (true) do
		mSleep(math.random(500, 1000))
		x,y = findMultiColorInRegionFuzzy( 0x1a1a1a, "15|-4|0x1a1a1a,28|0|0x1a1a1a,14|17|0x1a1a1a,3|20|0x1a1a1a,25|18|0x1a1a1a,37|15|0x1a1a1a,53|-5|0x1a1a1a,58|16|0x1a1a1a,83|9|0xffffff", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x+400,y-70,8)
			mSleep(math.random(1000, 1500))
			break
		end

		mSleep(math.random(500, 1000))
		x, y = findMultiColorInRegionFuzzy(0,"28|1|0,15|-2|0,14|20|0,3|22|0,26|20|0,38|18|0,54|-3|0,53|18|0", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x+400,y-70,8)
			mSleep(math.random(1000, 1500))
			break
		end
	end

	mSleep(math.random(500, 700))
	if api_change == "0" then
		if country_id == "0" then
			phone = string.sub(service_phone,5,#service_phone)
		else
			phone = string.sub(service_phone,4,#service_phone)
		end
	elseif api_change == "1" then
		phone = tmp.number
	elseif api_change == "2" then
		if country_num ~= "86" then
			b,c = string.find(telphone,phone_country)
			if c ~= nil then
				phone = string.sub(telphone,#phone_country + 1,#telphone)
			else
				phone = telphone
			end
		else
			phone = telphone
		end
	elseif api_change == "3"  or api_change == "7" then
		phone = telphone
	elseif api_change == "4" then
		b,c = string.find(string.sub(telphone,1,#country_num),country_num)
		if c ~= nil then
			phone = string.sub(telphone,c+1,#telphone)
		else
			phone = telphone
		end
	elseif api_change == "5" then
		phone = string.sub(telphone, #country_num + 2,#telphone)
	elseif api_change == "6" then
		phone = string.sub(telphone, #country_num + 1 ,#telphone)
	end

	toast(phone,1)
	mSleep(1200)
	for i = 1, #phone do
		mSleep(math.random(500, 700))
		num = string.sub(phone,i,i)
		if num == "0" then
			randomsTap(373, 1281, 8)
		elseif num == "1" then
			randomsTap(132,  955, 8)
		elseif num == "2" then
			randomsTap(377,  944, 8)
		elseif num == "3" then
			randomsTap(634,  941, 8)
		elseif num == "4" then
			randomsTap(128, 1063, 8)
		elseif num == "5" then
			randomsTap(374, 1061, 8)
		elseif num == "6" then
			randomsTap(628, 1055, 8)
		elseif num == "7" then
			randomsTap(119, 1165, 8)
		elseif num == "8" then
			randomsTap(378, 1160, 8)
		elseif num == "9" then
			randomsTap(633, 1164, 8)
		end
	end

	if password == "0" then
		mSleep(500)
		password = "vip"..string.sub(phone,#phone-4,#phone)
	elseif password == "1" then
		mSleep(500)
		password = "hang"..string.sub(phone,#phone-3,#phone)
	elseif password == "2" then
		mSleep(500)
		password = "wypn"..string.sub(phone,#phone-3,#phone)
	end
	toast(password,1)
	mSleep(1000)

	--密码
	while (true) do
		mSleep(math.random(1000, 1500))
		x,y = findMultiColorInRegionFuzzy( 0x1a1a1a, "15|-4|0x1a1a1a,28|0|0x1a1a1a,14|17|0x1a1a1a,3|20|0x1a1a1a,25|18|0x1a1a1a,37|15|0x1a1a1a,53|-5|0x1a1a1a,58|16|0x1a1a1a,83|9|0xffffff", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x+400,y,8)
			mSleep(math.random(1000, 1500))
			inputStr(password)
			mSleep(math.random(500, 700))
			break
		end

		mSleep(math.random(500, 1000))
		x, y = findMultiColorInRegionFuzzy(0,"28|1|0,15|-2|0,14|20|0,3|22|0,26|20|0,38|18|0,54|-3|0,53|18|0", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x+400,y,8)
			mSleep(math.random(1000, 1500))
			inputStr(password)
			mSleep(math.random(500, 700))
			break
		end
	end

	::change_again::
	if vpn_country == "0" then
		self:changeGNIP(place_id,iptimes)
	elseif vpn_country == "1" then
		self:changeGWIP(ip_country)
	end

	mSleep(2000)
	ip = self:vpn()
	toast(ip,1)
	mSleep(1200)

	if wc_version == "1" then
		--点击协议
		while (true) do
			mSleep(math.random(500, 1000))
			x, y = findMultiColorInRegionFuzzy(0,"28|1|0,15|-2|0,14|20|0,3|22|0,26|20|0,38|18|0,54|-3|0,53|18|0", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				randomsTap(x+19,y+164,4)
				mSleep(math.random(1000, 1500))
				break
			end
		end
	end

	next_again_time = 1
	againLogin_bool = false
	::next_again::
	if againLogin_bool then
		phone_loginTime = readFile(userPath().."/res/phone_loginTime.txt")
		toast(phone_loginTime[1],1)
		if tonumber(phone_loginTime[1]) < tonumber(fz_error_times) then
			writeFileString(userPath().."/res/phone_loginTime.txt",tostring(tonumber(phone_loginTime[1]) + 1),"w",0)
			toast("辅助失败，号码返回重新注册:"..phone_loginTime[1],1)
			mSleep(2000)
			setVPNEnable(true)
			mSleep(3000)
		else
			if api_change == "2" then
				::addblack::
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=addBlack&token="..phone_token.."&pid="..pid.."&reason="..urlEncoder("获取失败"))
				mSleep(500)
				if code == 200 then
					data = strSplit(res, "|")
					if data[1] == "1" then
						toast("拉黑手机号码",1)
					else
						goto addblack
					end
				end
			elseif api_change == "7" then
				::push::
				mSleep(500)
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://47.104.246.33/phone.php?cmd=poststatus&phone="..phone.."&status=失败")
				mSleep(500)
				if code == 200 then
					if reTxtUtf8(res) == "反馈成功" then
						toast("号码状态标记成功",1)
					else
						goto push
					end
				else
					toast("标记失败，重新标记",1)
					mSleep(3000)
					goto push
				end
			end
			writeFileString(userPath().."/res/phone_data.txt","","w",0)
			toast("超过"..fz_error_times.."次注册失败，重新获取注册",1)
			goto over
		end
	end

	--协议后下一步
	while (true) do
		mSleep(math.random(500, 700))
		x,y = findMultiColorInRegionFuzzy( 0xffffff, "-63|12|0x07c160,128|13|0x07c160,54|13|0xffffff,295|-2|0x07c160,-262|6|0x07c160", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x,y,10)
			mSleep(math.random(500, 700))
			break
		end

		x, y = findMultiColorInRegionFuzzy(0x9ce6bf,"540|-7|0x9ce6bf,270|30|0x9ce6bf,270|-89|0x576b95",90,0,0,749,1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x+100,y,10)
			mSleep(math.random(500, 700))
			break
		end
	end

	erweima_bool = false
	::erweima::
	if erweima_bool then
		if country_id == "0" then
			mSleep(math.random(1000, 1700))
			randomsTap(373, 1035,10)
			mSleep(math.random(500, 700))
		else
			mSleep(math.random(1000, 1700))
			randomsTap(373, 769,10)
			mSleep(math.random(500, 700))
		end
		erweima_bool = false
	end

	--隐秘政策
	time = 0
	while (true) do
		if country_num == "86" then
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0xd8f0d8,"-254|21|0x9ed99d,368|13|0x9ed99d,61|-20|0x9ed99d,49|46|0x9ed99d",100, 0, 966, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 1000))
				randomsTap(x-277, y-100,1)
				mSleep(math.random(3000, 5000))
				break
			else
				time = time + 1
				toast("等待隐秘政策"..time,1)
				mSleep(math.random(2000, 3000))
			end
		else
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0xc2c2c2,"13|19|0xc2c2c2,52|12|0xc2c2c2,83|0|0xc2c2c2,84|16|0xc2c2c2,-111|-5|0xf2f2f2,219|43|0xf2f2f2,274|18|0xededed,-172|9|0xededed", 100, 0, 924, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 1000))
				randomsTap(x - 240, y-95,1)
				mSleep(math.random(3000, 5000))
				break
			else
				mSleep(math.random(500, 700))
				x,y = findMultiColorInRegionFuzzy( 0xc2c2c2, "-148|-7|0xf2f2f2,140|2|0xf2f2f2,245|2|0xededed,-175|6|0xf2f2f2", 100, 0, 1145, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 1000))
					randomsTap(x, y-112,1)
					mSleep(math.random(3000, 5000))
					break
				else
					time = time + 1
					toast("等待隐秘政策"..time,1)
					mSleep(math.random(2000, 3000))
				end
			end
		end

		--欧盟国家需要多下一步
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0xffffff,"37|5|0xffffff,-108|11|0x7c160,37|-16|0x7c160,182|8|0x7c160,42|34|0x7c160", 100, 0, 1000, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x, y,5)
			mSleep(math.random(500, 700))
			toast("欧盟国家下一步",1)
		end

		--无效手机号码
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x576b95,"-28|1|0x576b95,-38|-232|0,20|-223|0,-195|149|0x36030,159|133|0x36030", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(200, 500))
			randomsTap(x, y,1)
			mSleep(math.random(3000, 5000))
			if api_change == "2" then
				::addblack::
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=addBlack&token="..phone_token.."&pid="..pid.."&reason="..urlEncoder("获取失败"))
				mSleep(500)
				if code == 200 then
					data = strSplit(res, "|")
					if data[1] == "1" then
						toast("拉黑手机号码",1)
					else
						goto addblack
					end
				end
			end
			writeFileString(userPath().."/res/phone_data.txt","","w",0)
			lua_restart()
		end

		if time > 40 then
			lua_restart()
		end
	end

	ys_next = 0
	--隐秘政策：下一步
	while (true) do
		if country_num == "86" then
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0xd8f0d8,"-254|21|0x9ed99d,368|13|0x9ed99d,61|-20|0x9ed99d,49|46|0x9ed99d",100, 0, 966, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 1000))
				randomsTap(x-277, y-100,1)
				mSleep(math.random(3000, 5000))
			end
		else
			mSleep(math.random(500, 700))
			x,y = findMultiColorInRegionFuzzy( 0xcdcdcd, "48|13|0xcdcdcd,80|4|0xcdcdcd,-87|11|0xfafafa,186|13|0xfafafa,50|34|0xfafafa,265|13|0xffffff", 100, 0, 966, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 1000))
				randomsTap(x-240, y-112,1)
				mSleep(math.random(3000, 5000))
			else
				mSleep(math.random(500, 700))
				x,y = findMultiColorInRegionFuzzy( 0xc2c2c2, "-148|-7|0xf2f2f2,140|2|0xf2f2f2,245|2|0xededed,-175|6|0xf2f2f2", 100, 0, 1145, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(math.random(500, 1000))
					randomsTap(x, y-98,1)
					mSleep(math.random(3000, 5000))
				end
			end
		end

		--86   272,1235,0x1aad19}
		mSleep(math.random(500, 700))
		if getColor(272,1235) == 0x1aad19 then
			mSleep(math.random(2500, 4700))
			randomsTap(272,1235,10)
			mSleep(math.random(1000, 1700))
			toast("隐秘政策同意，下一步",1)
			mSleep(1000)
			ys_next = ys_next + 1
		end

		mSleep(math.random(500, 700))
		if getColor(300, 1201) == 0x07c160 then
			mSleep(math.random(1000, 1700))
			randomsTap(370, 1204,10)
			mSleep(math.random(1000, 1700))
			toast("下一步",1)
			mSleep(1000)
			ys_next = ys_next + 1
		end

		--欧盟国家
		mSleep(math.random(500, 700))
		if getColor(289,1106) == 0x7c160 and getColor(372,1107) == 0xffffff then
			mSleep(math.random(1000, 1700))
			randomsTap(289,1108,10)
			mSleep(math.random(1000, 1700))
			toast("下一步2",1)
			ys_next = ys_next + 1
		end

		mSleep(math.random(500, 700))
		if getColor(353,  287) == 0x10aeff and getColor(304, 1105) == 0x07c160 then
			toast("准备安全验证",1)
			mSleep(2000)
			break
		end

		--无效手机号码
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x576b95,"-28|1|0x576b95,-38|-232|0,20|-223|0,-195|149|0x36030,159|133|0x36030", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(200, 500))
			randomsTap(x, y,1)
			mSleep(math.random(3000, 5000))
			if api_change == "2" then
				::addblack::
				local sz = require("sz")        --登陆
				local http = require("szocket.http")
				local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=addBlack&token="..phone_token.."&pid="..pid.."&reason="..urlEncoder("获取失败"))
				mSleep(500)
				if code == 200 then
					data = strSplit(res, "|")
					if data[1] == "1" then
						toast("拉黑手机号码",1)
					else
						goto addblack
					end
				end
			end
			writeFileString(userPath().."/res/phone_data.txt","","w",0)
			lua_restart()
		end

		mSleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "-28|5|0x576b95,17|-156|0x000000,-147|-170|0x000000,169|-95|0xf9f7fa", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(200, 500))
			randomsTap(x, y,1)
			mSleep(math.random(3000, 5000))
			toast("连接失败",1)
			mSleep(1000)
			goto next_again
		end

		if ys_next > 40 then
			mSleep(500)
			lua_restart()
		else
			mSleep(1000)
			toast("隐私下一步："..ys_next,1)
			ys_next = ys_next + 1
			mSleep(6000)
		end
	end

	fz_bool = false
	tiaoma_bool = false
	phone_help = false
	fm_bool = false
	out_login = false
	send_fm_bool = false

	if fz_type == "5" then
		hk_url = self:get_hkUrl(country_num)
		regid = string.match(hk_url, '%d+_%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+%d+')
		hk_url = urlEncoder(hk_url)
		toast(hk_url,1)
		::put_work::
		header_send = {
		}
		body_send = string.format("key=%s&url=%s&tel=%s&area=%s&scanType=%s&regid=%s",fz_key, hk_url, phone, country_num,2,regid)
		ts.setHttpsTimeOut(80)--安卓不支持设置超时时间 
		status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/tj", header_send, body_send, true)
		mSleep(1000)
		if status_resp == 200 then
			mSleep(500)
			local tmp = json.decode(body_resp)
			if tmp.success then
				old = tmp.data.oId
				toast("滑块链接发布成功:"..old,1)
				mSleep(5000)
			else
				mSleep(500)
				toast("发布失败，6秒后重新发布",1)
				mSleep(6000)
				goto put_work
			end
		else
			goto put_work
		end
	elseif fz_type == "6" then
		hk_url = self:get_hkUrl(country_num)
		hk_url = urlEncoder(hk_url)
		toast(hk_url,1)
		::put_work::
		header_send = {
		}
		body_send = string.format("url=%s&mark=%s&merchant=%s",hk_url, phone, fz_key)
		ts.setHttpsTimeOut(80)--安卓不支持设置超时时间 
		status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/create.action", header_send, body_send, true)
		mSleep(1000)
		if status_resp == 200 then
			mSleep(500)
			local tmp = json.decode(body_resp)
			if tmp.code == "200" then
				order_sn = tmp.data.order_sn
				toast("滑块链接发布成功:"..order_sn,1)
				mSleep(5000)
			else
				mSleep(500)
				toast("发布失败，6秒后重新发布",1)
				mSleep(6000)
				goto put_work
			end
		else
			goto put_work
		end
	elseif fz_type == "8" then
		hk_url = self:get_hkUrl(country_num)
		hk_url = urlEncoder(hk_url)
		toast(hk_url,1)
	end

	--安全验证
	::get_pic::
	safe_time = 0
	while (true) do
		mSleep(math.random(700, 900))
		x, y = findMultiColorInRegionFuzzy(0x10aeff,"55|8|0x10aeff,-79|817|0x7c160,116|822|0x7c160", 100, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			if hk_way == "1" then
				mSleep(math.random(1000, 1500))
				randomsTap(372, 1105,10)
			end
			mSleep(math.random(1000, 1500))
			toast("安全验证=="..phone.."=="..country_num,1)
			mSleep(1000)
			randomsTap(372, 1105,10)
			mSleep(math.random(1000, 1500))
			break
		else
			toast("安全验证等待："..safe_time,1)
			safe_time = safe_time + 1
		end

		if safe_time > 40 then
			lua_restart()
		end
	end

	::hk::
	if hk_way == "0" then
		--滑块
		safe = 0
		hk_time = 0
		while (true) do
			mSleep(math.random(500, 700))
			if getColor(118,  948) == 0x007aff then
				x_lens = self:moves()
				if tonumber(x_lens) > 0 then
					mSleep(math.random(500, 700))
					moveTowards( 108,  952, 0, x_len-75)
					mSleep(3000)
				else
					mSleep(math.random(500, 1000))
					randomsTap(689, 1032,10)
					mSleep(math.random(3000, 6000))
					goto get_pic
				end
				break
			else
				toast("滑块等待："..hk_time,1)
				hk_time = hk_time + 1
			end

			mSleep(math.random(500, 700))
			x,y = findMultiColorInRegionFuzzy( 0x000000, "-8|9|0x000000,12|1|0x000000,12|14|0x000000,-1|18|0x000000,27|21|0x000000,50|21|0x000000,18|11|0xffffff,538|558|0xb3b3b3", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(1000, 1500))
				tap(x + 600, y + 569)
				mSleep(math.random(1000, 1500))
				goto get_pic
			end

			mSleep(math.random(700, 900))
			x, y = findMultiColorInRegionFuzzy(0x10aeff,"55|8|0x10aeff,-79|817|0x7c160,116|822|0x7c160", 100, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(1000, 1500))
				randomsTap(372, 1105,10)
				mSleep(math.random(1000, 1500))
				toast("安全验证",1)
				safe = safe + 1
			end

			if safe > 40 then
				mSleep(500)
				mSleep(math.random(500, 700))
				randomsTap(56, 81, 8)
				mSleep(math.random(500, 700))
				goto next_again
			else
				toast("安全验证等待"..safe,1)
				mSleep(1000)
			end

			if hk_time > 40 then
				lua_restart()
			end

		end
	end

	if fz_type == "0" or fz_type == "9" or fz_type == "10" or fz_type == "11" or fz_type == "12" then
		--二维码识别
		while (true) do
			mSleep(math.random(500, 700))
			if getColor(132,  766) == 0x000000 then
				mSleep(math.random(500, 700))
				snapshot("1.png", 109,  701, 442, 1073)
				mSleep(math.random(1000, 1500))
				base_six_four = self:readFileBase64(userPath().."/res/1.png") 
				::ewm_go::
				header_send = {
					["Content-Type"] = "application/x-www-form-urlencoded",
				}
				body_send = {
					["base64"] = urlEncoder("data:image/png;base64,"..base_six_four),
				}
				ts.setHttpsTimeOut(60)
				code,header_resp, body_resp = ts.httpsPost("http://api.qianxing666.com/api/open-api/orders/decode", header_send,body_send)
				if code == 200 then
					ewm_url = body_resp  
					toast(ewm_url,1)
					mSleep(1000)
					ewm_url_bool =  true
				else
					toast("二维码失败失败:"..body_resp,1)
					mSleep(6000)
					snaPicError = true
					goto ewm_go
				end
				break
			end

			if hk_way == "0" then
				mSleep(math.random(500, 700))
				if getColor(118,  948) == 0x007aff then
					mSleep(math.random(500, 1000))
					randomsTap(603, 1032,5)
					mSleep(math.random(3000, 6000))
					goto hk
				end
			end

			if api_change == "7" then
				mSleep(math.random(500, 700))
				x, y = findMultiColorInRegionFuzzy(0x576b95,"-38|1|0x576b95,-314|-9|0x181819,-356|-3|0x181819,-157|-155|0,24|-174|0",90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					toast("操作频繁",1)
					mSleep(500)
					writeFileString(userPath().."/res/phone_data.txt","","w",0)
					goto gg
				end
			end
		end
	elseif fz_type == "3" then
		while (true) do
			mSleep(math.random(500, 700))
			if getColor(132, 766) == 0x000000 and getColor(54,648) == 0x808080 then
				mSleep(500)
				next_again_time = next_again_time + 1
				if next_again_time > 3 then
					mSleep(500)
					if api_change == "2" then
						::addblack::
						local sz = require("sz")        --登陆
						local http = require("szocket.http")
						local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=addBlack&token="..phone_token.."&pid="..pid.."&reason="..urlEncoder("获取失败"))
						mSleep(500)
						if code == 200 then
							data = strSplit(res, "|")
							if data[1] == "1" then
								toast("拉黑手机号码",1)
							else
								goto addblack
							end
						end
					elseif api_change == "4" then
						::addblack::
						local sz = require("sz")        --登陆
						local http = require("szocket.http")
						local res, code = http.request("http://129.204.138.57:11223/api/Camel/addblack?token="..tokens.."&skey="..skey)
						mSleep(500)
						if code == 200 then
							tmp = json.decode(res)
							if tmp.Status == 200 then
								toast("跳马失败加黑手机号码",1)
								mSleep(1000)
							else
								goto addblack
							end
						end
					end

					toast("重新新机注册",1)
					new_bool = true
					mSleep(1000)
					goto over
				else
					mSleep(500)
					randomsTap(56,83,3)
					mSleep(500)
					toast("跳马失败："..next_again_time,1)
					mSleep(1000)
					goto next_again
				end
			end

			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0x353535,"44|23|0x353535,67|20|0x353535,-6|331|0,30|317|0,67|317|0,105|455|0x9ce6bf,486|480|0x9ce6bf", 100, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				toast("短信界面",1)
				ewm_url_bool = true
				tiaoma_bool = true
				break
			end

			if hk_way == "0" then
				mSleep(math.random(500, 700))
				if getColor(118,  948) == 0x007aff then
					mSleep(math.random(500, 1000))
					randomsTap(603, 1032,5)
					mSleep(math.random(3000, 6000))
					goto hk
				end
			end

			mSleep(math.random(500,700))
			if getColor(390,822) == 0x576b95 and getColor(363,822) == 0x576b95 then
				mSleep(500)
				randomsTap(390,822,5)
				mSleep(500)
				toast("拒收微信登录",1)
				goto next_again
			end
		end
	elseif fz_type == "1" or fz_type == "2" or fz_type == "4" or fz_type == "5" or fz_type == "6" or fz_type == "8" then
		while (true) do
			mSleep(math.random(500, 700))
			if getColor(132,  766) == 0x000000 or getColor(256,  639) == 0x9ce6bf then
				mSleep(500)
				if fz_type == "1" then
					::put_work::
					header_send = {
					}
					body_send = string.format("userKey=%s&phone=%s&region=%s&receiveProvinceId=%s",fz_key, phone, country_num, fz_province)
					ts.setHttpsTimeOut(80)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://ymka.ymassist.com/assist/api/order/submitPhone", header_send, body_send, true)
					mSleep(1000)
					if status_resp == 200 then
						mSleep(500)
						local tmp = json.decode(body_resp)
						if tmp.success then
							toast("发布成功，等待20秒查询",1)
							mSleep(20000)
						else
							goto put_work
						end
					else
						goto put_work
					end

					::push_work::
					header_send = {
						typeget = "ios"
					}
					body_send = string.format("phone=%s&region=%s",phone,country_num)
					ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://ymka.ymassist.com/assist/api/order/queryPhone", header_send, body_send, true)
					mSleep(1000)
					if status_resp == 200 then
						local tmp = json.decode(body_resp)
						if tmp.success then
							if tmp.object.status == 3 then
								ewm_url_bool = true
								fz_bool = true
								toast("辅助成功",1)
								mSleep(1200)
							elseif tmp.object.status == 2 then
								toast("辅助失败",1)
								mSleep(1000)
								goto over
							else
								toast(body_resp,1)
								mSleep(5000)
								goto push_work
							end
						else
							toast("查询辅助状态",1)
							mSleep(5000)
							goto push_work
						end
					else
						goto push_work
					end
				elseif fz_type == "2" then
					::put_work::
					header_send = {
					}
					body_send = string.format("merchant=%s&phone=%s&area=%s", fz_key, phone, country_num)

					ts.setHttpsTimeOut(80)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/phone.action", header_send, body_send, true)
					mSleep(1000)
					if status_resp == 200 then
						mSleep(500)
						local tmp = json.decode(body_resp)
						if tmp.code == "200" then
							toast("发布成功，20秒后开始查询",1)
							mSleep(20000)
						else
							goto put_work
						end
					else
						goto put_work
					end

					::push_work::
					header_send = {
					}
					body_send = string.format("merchant=%s&phone=%s",fz_key, phone)

					ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/inquiry.action", header_send, body_send, true)

					mSleep(1000)
					if status_resp == 200 then
						mSleep(500)
						local tmp = json.decode(body_resp)
						if tmp.data.status == 2 then
							ewm_url_bool = true
							fz_bool = true
							toast("辅助成功",1)
							mSleep(1000)
						elseif tmp.data.status == 1 then
							toast("等待辅助中："..tmp.message,1)
							mSleep(5000)
							goto push_work
						elseif tmp.data.status == 3 or tmp.data.status == 4 or tmp.data.status == 5 or tmp.data.status == 6 then
							mSleep(500)
							toast("辅助超时，失败了",1)
							mSleep(1000)
							goto over
						elseif tmp.data.status == 0 then
							toast("未接单",1)
							mSleep(5000)
							goto push_work
						end
					else
						goto push_work
					end
				elseif fz_type == "4" then
					::put_work::
					header_send = {
					}
					body_send = string.format("key=%s&tel=%s&area=%s", fz_key, phone, country_num)

					ts.setHttpsTimeOut(80)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/phonetj", header_send, body_send, true)
					mSleep(1000)
					nLog(body_resp)
					if status_resp == 200 then
						mSleep(500)
						local tmp = json.decode(body_resp)
						if tmp.success then
							id = tmp.data.id
							toast("发布成功，20秒后开始查询",1)
							mSleep(20000)
						else
							goto put_work
						end
					else
						goto put_work
					end

					::push_work::
					header_send = {
					}
					body_send = string.format("key=%s&id=%s", fz_key, id)

					ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/phonecx", header_send, body_send, true)
					nLog(body_resp)
					mSleep(1000)
					if status_resp == 200 then
						mSleep(500)
						local tmp = json.decode(body_resp)
						if tmp.success then
							if tmp.data.status == 3 then
								ewm_url_bool = true
								fz_bool = true
								toast("辅助成功",1)
								mSleep(1000)
							elseif tmp.data.status == 2 or tmp.data.status == 0 then
								toast("等待辅助中："..tmp.data.showString,1)
								mSleep(5000)
								goto push_work
							elseif tmp.data.status == 4 or tmp.data.status == 9 then
								mSleep(500)
								toast("辅助超时，失败了:"..tmp.data.showString,1)
								mSleep(1000)
								goto over
							else
								toast(tmp.data.showString,1)
								mSleep(5000)
								goto push_work
							end
						end
					else
						goto push_work
					end
				elseif fz_type == "5" or fz_type == "6" or fz_type == "8" then
					if fz_type == "8" then
						::put_work::
						header_send = {}
						body_send = string.format("userKey=%s&qrCodeUrl=%s&phone=%s",fz_key,hk_url,phone)
						ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
						status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/submit", header_send, body_send, true)
						if status_resp == 200 then
							local tmp = json.decode(body_resp)
							if tmp.success then
								taskId = tmp.obj.orderId
								toast("发布成功,id:"..tmp.obj.orderId,1)
							else
								goto put_work
							end
						else
							goto put_work
						end
					end

					if fz_type == "8" then
						time = os.time() + 390
					else
						time = os.time() + 310
					end

					while true do
						mSleep(math.random(500, 700))
						x, y = findMultiColorInRegionFuzzy(0x7c160,"282|6|0x7c160,121|9|0xffffff,136|-18|0x7c160,133|39|0x7c160,99|-812|0x7c160,165|-790|0x7c160,128|-792|0xffffff", 90, 0, 0, 749, 1333)
						if x~=-1 and y~=-1 then
							mSleep(math.random(500, 700))
							self:change_vpn()
							toast("返回注册流程",1)
							break
						end

						mSleep(500)
						if getColor(256,  639) == 0x9ce6bf then
							break
						end

						mSleep(500)
						x,y = findMultiColorInRegionFuzzy( 0xfa5151, "49|1|0xfa5151,-154|787|0x07c160,180|843|0x07c160,186|795|0x07c160,-130|847|0x07c160", 90, 0, 0, 749, 1333)
						if x~=-1 and y~=-1 then
							mSleep(math.random(500, 700))
							setVPNEnable(false)
							toast("系统繁忙，稍后再试",1)
							serviceError = true
							goto bj_fail
						end

						new_time = os.time()
						if new_time >= time then
							ewm_url_bool = false
							toast("辅助超时，进入标记失败订单",1)
							goto bj_fail
						else
							toast(time - new_time,1)
							mSleep(5000)
						end
					end
				end

				while true do
					mSleep(math.random(500, 700))
					x, y = findMultiColorInRegionFuzzy(0x7c160,"282|6|0x7c160,121|9|0xffffff,136|-18|0x7c160,133|39|0x7c160,99|-812|0x7c160,165|-790|0x7c160,128|-792|0xffffff", 90, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(math.random(500, 700))
						tap(x + 150, y)
						mSleep(math.random(1200, 1700))
						toast("返回注册流程",1)
					end

					mSleep(math.random(500, 700))
					x, y = findMultiColorInRegionFuzzy(0x353535,"44|23|0x353535,67|20|0x353535,-6|331|0,30|317|0,67|317|0,105|455|0x9ce6bf,486|480|0x9ce6bf", 100, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						toast("辅助成功，短信界面",1)
						ewm_url_bool = true
						phone_help = true
						mSleep(1000)
						break
					end

					mSleep(math.random(500, 700))
					x, y = findMultiColorInRegionFuzzy(0,"136|3|0,-73|686|0x7c160,330|683|0x7c160,170|683|0xffffff,116|826|0x6ae56,205|815|0x6ae56",100, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						toast("辅助成功，发码界面",1)
						mSleep(1000)
						ewm_url_bool = false
						fm_bool = true
						mSleep(1000)
						break
					end
				end
				break
			end

			if hk_way == "0" then
				mSleep(math.random(500, 700))
				if getColor(118,  948) == 0x007aff then
					mSleep(math.random(500, 1000))
					randomsTap(603, 1032,5)
					mSleep(math.random(3000, 6000))
					goto hk
				end
			end

			if api_change == "7" then
				mSleep(math.random(500, 700))
				x, y = findMultiColorInRegionFuzzy(0x576b95,"-38|1|0x576b95,-314|-9|0x181819,-356|-3|0x181819,-157|-155|0,24|-174|0",90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					toast("操作频繁",1)
					mSleep(500)
					writeFileString(userPath().."/res/phone_data.txt","","w",0)
					goto gg
				end
			end
		end

		if fm_bool then
			while true do
				mSleep(math.random(500, 700))
				x, y = findMultiColorInRegionFuzzy(0,"136|3|0,-73|686|0x7c160,330|683|0x7c160,170|683|0xffffff,116|826|0x6ae56,205|815|0x6ae56",100, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(500)
					if api_change == "2" then
						local m = TSVersions()
						local a = ts.version()
						local API = "Hk8Ve2Duh6QCR5XUxLpRxPyv"
						local Secret  = "fD0az8pW8lNhGptCZC4TPfMWX5CyVtnh"
						local tp = getDeviceType()
						if m <= "1.2.7" then
							dialog("请使用 v1.2.8 及其以上版本 TSLib",0)
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

						local code1,access_token = getAccessToken(API,Secret)
						if code1 then
							local content_name1 = userPath() .. "/res/baiduAI_content_name1.jpg"
							local content_name2 = userPath() .. "/res/baiduAI_content_name2.jpg"
							local phone_name = userPath() .. "/res/baiduAI_phone_name.jpg"
							--内容
							snapshot(content_name1, 21,592,98,649) 
							mSleep(100)
							snapshot(content_name2, 96,592,167,658) 
							mSleep(100)
							--号码
							snapshot(phone_name, 20,765,601,835)  
							local code2, body = baiduAI(access_token,content_name1)
							if code2 then
								local tmp = json.decode(body)
								for i=1,#tmp.words_result,1 do
									mSleep(200)
									content_num1 = string.lower(tmp.words_result[i].words)
								end
								if #content_num1 > 2 then
									content_num1 = string.sub(content_num1,1,2)
								end

							else
								dialog("识别失败\n" .. body,5)
								goto over
							end 

							local code2, body = baiduAI(access_token,content_name2)
							if code2 then
								local tmp = json.decode(body)
								for i=1,#tmp.words_result,1 do
									mSleep(200)
									content_num2 = string.lower(tmp.words_result[i].words)
									if #content_num2 > 2 then
										content_num2 = string.sub(content_num2,#content_num2 - 1,#content_num2)
									end
								end
							else
								dialog("识别失败\n" .. body,5)
								goto over
							end 

							local code2, body = baiduAI(access_token,phone_name)
							if code2 then
								local tmp = json.decode(body)
								for i=1,#tmp.words_result,1 do
									mSleep(200)
									phone_num = string.lower(tmp.words_result[i].words)
								end
							else
								dialog("识别失败\n" .. body,5)
								goto over
							end
						else
							dialog("识别失败\n" .. access_token,5)
							goto over
						end

						toast(phone_num.."\r\n"..content_num1.."\r\n"..content_num2,1)
						mSleep(1000)
						::send_message::
						mSleep(500)
						local sz = require("sz")        --登陆
						local http = require("szocket.http")
						local res, code = http.request("http://api5.caugu.com/yhapi.ashx?act=sendCode&token="..phone_token.."&pid="..pid.."&receiver="..phone_num.."&smscontent="..content_num1..content_num2)
						mSleep(500)
						if code == 200 then
							data = strSplit(res, "|")
							if data[1] == "1" then
								mSleep(10000)
								randomsTap(384,1131,6)
								mSleep(5000)
								toast("发送短信成功",1)
								mSleep(1000)
								send_fm_bool = true
							elseif data[1] == "0" then
								mSleep(500)
								if data[2] == "-3" then
									toast("接收号码不能为空",1)
									mSleep(1000)
									goto over
								elseif data[2] == "-4" then
									toast("提交短信不能为空",1)
									mSleep(1000)
									goto over
								elseif data[2] == "-10" then
									toast("发送内容不符合规则",1)
									mSleep(1000)
									goto over
								end
								toast("发送短信失败，重新发送",1)
								mSleep(1000)
								goto send_message
							end
						else
							toast("获取手机号码失败，重新获取",1)
							mSleep(1000)
							goto send_message
						end
					end
					ewm_url_bool = false
					country_id = "0"
					break
				end
			end
		end
	elseif fz_type == "7" then
		toast("手动上传辅助二维码",1)
		mSleep(20000)
		ewm_url_bool = true
	end

	::bj_fail::
	clean_bool = false
	if ewm_url_bool then
		fz_success_bool = self:ewm(login_times,phone_help,skey,tiaoma_bool,fz_bool,fz_type,phone,phone_token,api_change,SMS_country,pid,pay_id,ewm_url,provinceId,tzid,getPhone_key,sumbit_key,codeUrl,messGetTime,messSendTime)
		if fz_type == "0" or fz_type == "1" or fz_type == "2" or fz_type == "5" or fz_type == "4" or fz_type == "6" or fz_type == "8" or fz_type == "9" or fz_type == "10" or fz_type == "11" or fz_type == "12" then
			if fz_success_bool then
				toast("辅助成功",1)
				if api_change == "2" or api_change == "6" or api_change == "7" then
					writeFileString(userPath().."/res/phone_data.txt","","w",0)
					toast("清空保存号码文件",1)
				end
				clean_bool = true
			else
				toast("辅助失败",1)
				if fz_type == "5" then
					--标记订单
					::bj::
					local sz = require("sz");
					local http = require("szocket.http")
					local res, code = http.request("http://api.tvnxl.com/xd/xg?key="..fz_key.."&oId="..old.."&sts=fail")
					if code == 200 then
						tmp = json.decode(res)
						if tmp.success then
							toast("订单标记："..tmp.data, 1)
							mSleep(3000)
						else
							toast("标记失败:"..res,1)
							mSleep(2000)
							goto bj
						end
					end
				elseif fz_type == "6" then
					::push_work::
					header_send = {}
					body_send = string.format("order_sn=%s&status=%s&merchant=%s",order_sn,"2",fz_key)
					ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/change.action", header_send, body_send, true)
					if status_resp == 200 then
						local tmp = json.decode(body_resp)
						if tmp.code == "200" then
							toast("标记成功",1)
						else
							toast("标记失败:"..body_resp,1)
							mSleep(2000)
							goto push_work
						end
					else
						toast("标记失败:"..body_resp,1)
						mSleep(2000)
						goto push_work
					end
				elseif fz_type == "8" then
					::push_work::
					header_send = {}
					body_send = string.format("userKey=%s&orderId=%s&status=%s",fz_key,taskId,2)
					ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
					if status_resp == 200 then
						local tmp = json.decode(body_resp)
						if tmp.success then
							toast("标记成功",1)
						else
							goto push_work
						end
					else
						goto push_work
					end
				elseif fz_type == "9" then
					::push_work::
					header_send = {}
					body_send = string.format("userKey=%s&orderId=%s&status=%s",sumbit_key,taskId,2)
					ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
					if status_resp == 200 then
						local tmp = json.decode(body_resp)
						if tmp.success then
							toast("标记成功",1)
						elseif tmp.msg == "已提交任务结果" then
							toast("订单可能未接单退款了："..tmp.msg,1)
							mSleep(2000)
						elseif tmp.code == 1 then
							toast(tmp.msg,1)
							mSleep(2000)
						else
							toast(body_resp,1)
							mSleep(3000)
							goto push_work
						end
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				elseif fz_type == "10" then
					::push_work::
					header_send = {}
					body_send = string.format("key=%s&oId=%s&sts=%s",sumbit_key,oId,"fail")
					ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
					status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/xg", header_send, body_send, true)
					if status_resp == 200 then
						local tmp = json.decode(body_resp)
						if tmp.success then
							toast("标记成功",1)
						elseif tmp.code == "3" or tmp.code == "4" or tmp.code == "5" or tmp.code == "7" or tmp.code == "6" then
							toast(tmp.msg,1)
							mSleep(2000)
						else
							toast(body_resp,1)
							mSleep(3000)
							goto push_work
						end
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				elseif fz_type == "11" then
					::push_work::
					header_send = {
						["Content-Type"] = "application/x-www-form-urlencoded",
					}
					body_send = {
						["userKey"] = sumbit_key,
						["orderId"] = orderId,
						["status"] = 2,
					}
					ts.setHttpsTimeOut(60)
					code,header_resp, body_resp = ts.httpsPost("http://api.qianxing666.com/api/open-api/orders/mark", header_send,body_send)
					if code == 200 then
						local tmp = json.decode(body_resp)
						if tmp.success then
							toast("标记成功",1)
						else
							toast(body_resp,1)
							mSleep(3000)
							goto push_work
						end
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				elseif fz_type == "12" then
					::push_work::
					header_send = {token=string.format("%s", sumbit_key)}
					
					body_send = string.format("taskId=%s&status=%s", taskId, 3)
					ts.setHttpsTimeOut(60) -- 安卓不支持设置超时时间
					code,header_resp, body_resp = ts.httpPost("https://pu.xgtask.com/api/task/status", header_send,body_send)
					if code == 200 then
						mSleep(500)
						local tmp = json.decode(body_resp)
						if tmp.code == 200 then
							toast("标记成功",1)
						elseif tmp.message == "任务已被标记为成功" or tmp.message == "任务已被标记为失败" then
							toast("已经标记过该任务",1)
						else
							toast(body_resp,1)
							mSleep(3000)
							goto push_work
						end
					else
						goto push_work
					end
				end

				if login_times == "0" then
					if api_change == "6" or api_change == "7" then
						mSleep(500)
						randomsTap(55,83,3)
						mSleep(500)
						setVPNEnable(false)
						if vpn_country == "0" then
							self:changeGNIP(place_id,iptimes)
						elseif vpn_country == "1" then
							self:changeGWIP(ip_country)
						end
						setVPNEnable(true)
						againLogin_bool = true
						goto next_again
					else
						goto over
					end
				else
					goto over
				end

			end
		elseif fz_type == "3" then
			if fz_success_bool then
				toast("跳马辅助成功",1)
			else
				toast("跳马辅助失败",1)
				mSleep(500)
				goto run_app
			end
		elseif fz_type == "7" then
			if fz_success_bool then
				toast("辅助成功",1)
				clean_bool = true
				while true do
					mSleep(math.random(500, 700))
					x, y = findMultiColorInRegionFuzzy(0x1565fc,"1|14|0x1565fc,12|-4|0x1565fc,16|6|0x1565fc,12|21|0x1565fc,-174|-247|0", 90, 0, 0, 749, 1333)
					if x~=-1 and y~=-1 then
						mSleep(500)
						randomsTap(x,y,5)
						mSleep(500)
						break
					end
				end
				self:idCard()
			else
				mSleep(500)
				randomsTap(55,83,3)
				mSleep(500)
				setVPNEnable(false)
				if vpn_country == "0" then
					self:changeGNIP(place_id,iptimes)
				elseif vpn_country == "1" then
					self:changeGWIP(ip_country)
				end
				setVPNEnable(true)
				againLogin_bool = true
				goto next_again
			end
		end
	else
		if fz_type == "5" then
			--标记订单
			if send_fm_bool then
				::bj::
				local sz = require("sz");
				local http = require("szocket.http")
				local res, code = http.request("http://api.tvnxl.com/xd/xg?key="..fz_key.."&oId="..old.."&sts=success")

				if code == 200 then
					tmp = json.decode(res)
					if tmp.success then
						toast("订单标记："..tmp.data, 1)
						mSleep(3000)
					else
						toast("标记失败",1)
						mSleep(2000)
						goto bj
					end
				end
			else
				goto over
			end
		elseif fz_type == "6" then
			if send_fm_bool then
				::push_work::
				header_send = {
					typeget = "ios"
				}
				body_send = string.format("order_sn=%s&status=%s&merchant=%s",order_sn,"1",fz_key)
				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/change.action", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.code == "200" then
						toast("标记成功",1)
					else
						goto push_work
					end
				else
					goto push_work
				end
			else
				goto over
			end
		elseif fz_type == "8" then
			if send_fm_bool then
				::push_work::
				header_send = {}
				body_send = string.format("userKey=%s&orderId=%s&status=%s",fz_key,taskId,1)
				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					elseif tmp.msg == "已提交任务结果" then
						toast("订单可能未接单退款了："..tmp.msg,1)
						mSleep(2000)
						goto over
					else
						goto push_work
					end
				else
					goto push_work
				end
			else
				goto over
			end
		else
			mSleep(500)
			if not fm_bool then
				mSleep(math.random(500, 700))
				randomsTap(54, 79, 5)
				mSleep(math.random(1000, 1500))
				erweima_bool = true
				toast(ewm_url,1)
				goto erweima
			end
		end
	end

	--欧盟国家输入昵称
	if country_id ~= "0" then
		mSleep(500)
		while true do
			mSleep(500)
			x, y = findMultiColorInRegionFuzzy(0x343434,"49|-24|0x343434,2|547|0x9de7bf,326|537|0x9de7bf", 90, 0, 0, 749, 1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				randomsTap(355,590,8)
				mSleep(math.random(500, 700))
				toast("昵称",1)
				break
			end
			
			--不是我的，继续注册
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0x6ae56,"38|-2|0x6ae56,136|6|0x6ae56,182|-5|0x6ae56,261|-7|0x6ae56,290|-5|0x6ae56,-131|-11|0xf2f2f2,433|-3|0xf2f2f2", 90, 0, 0, 749,  1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				randomsTap(375,782,8)
				mSleep(math.random(500, 700))
				toast("不是我的，继续注册1",1)
			end

			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0x6ae56,"47|-11|0x6ae56,-98|-24|0x6ae56,-223|-18|0xededed,285|-15|0xededed", 90, 0, 0, 749,  1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				randomsTap(375,782,8)
				mSleep(math.random(500, 700))
				toast("不是我的，继续注册2",1)
			end

			--不是我的，继续注册
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0x6ae56,"36|1|0x6ae56,136|5|0x6ae56,181|-7|0x6ae56,294|-7|0x6ae56,371|0|0xf2f2f2,-98|-3|0xf2f2f2", 90, 0, 0, 749,  1333)
			if x~=-1 and y~=-1 then
				mSleep(math.random(500, 700))
				randomsTap(x,y,8)
				mSleep(math.random(500, 700))
				toast("不是我的，继续注册3",1)
			end
		end

		if nickName == "0" then  --英文
			for var= 1, 8 do
				num = math.random(1, 26) 
				mSleep(math.random(500, 700))
				if num > 0 and num < 11 then
					randomsTap(37+(num-1)*80,  967,8)
				elseif num > 10 and num < 20 then
					randomsTap(73+(num-11)*80, 1073,8)
				elseif num > 19 and num < 27 then
					randomsTap(147+(num-20)*80, 1179,8)
				end
				mSleep(math.random(500, 700))
			end
		elseif nickName == "1" then  --特殊符号
			mSleep(math.random(500, 700))
--			inputStr("르㸏مฬ้๊سمرًς.έل")
			inputStr("@")
		end

		mSleep(math.random(500, 700))
		randomsTap(369,740,8)
		mSleep(math.random(500, 700))

		while true do
			--填写生日
			mSleep(math.random(500, 700))
			x, y = findMultiColorInRegionFuzzy(0,"49|-16|0,-5|344|0x9ed99d,365|339|0x9ed99d", 100, 0, 0, 749, 800)
			if x~=-1 and y~=-1 then
				mSleep(math.random(1000, 1700))
				randomsTap(384,447,8)
				mSleep(math.random(500, 700))
				toast("点击生日",1)
			end

			mSleep(math.random(500, 700))
			if getColor(701,813) == 0x1aad19 then
				mSleep(math.random(1000, 1700))
				randomsTap(685,813,3)
				mSleep(math.random(500, 700))
				toast("确定",1)
			end

			mSleep(math.random(500, 700))
			if getColor(276,660) == 0x1aad19 then
				mSleep(math.random(1000, 1700))
				randomsTap(378,659,8)
				mSleep(math.random(500, 700))
				toast("下一步",1)
				break
			end
		end
	end

	not_get_code = 0
	while (true) do
		--通讯录匹配
		mSleep(math.random(500, 700))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "4|13|0x576b95,14|-4|0x576b95,14|6|0x576b95,18|18|0x576b95", 90, 0, 0, 645,  845)
		if x~=-1 and y~=-1 then
			mSleep(500)
			toast("通讯录匹配,等待8秒",1)
			setVPNEnable(false)
			break
		end

		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x1565fc,"1|14|0x1565fc,12|-4|0x1565fc,16|6|0x1565fc,12|21|0x1565fc,-174|-247|0", 90, 0, 0, 645,  845)
		if x~=-1 and y~=-1 then
			mSleep(500)
			toast("通讯录匹配,等待8秒",1)
			setVPNEnable(false)
			break
		end

		--不是我的，继续注册
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x6ae56,"38|-2|0x6ae56,136|6|0x6ae56,182|-5|0x6ae56,261|-7|0x6ae56,290|-5|0x6ae56,-131|-11|0xf2f2f2,433|-3|0xf2f2f2", 90, 0, 0, 749,  1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(375,782,8)
			mSleep(math.random(500, 700))
			toast("不是我的，继续注册1",1)
		end

		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x6ae56,"47|-11|0x6ae56,-98|-24|0x6ae56,-223|-18|0xededed,285|-15|0xededed", 90, 0, 0, 749,  1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(375,782,8)
			mSleep(math.random(500, 700))
			toast("不是我的，继续注册2",1)
		end

		--不是我的，继续注册
		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x6ae56,"36|1|0x6ae56,136|5|0x6ae56,181|-7|0x6ae56,294|-7|0x6ae56,371|0|0xf2f2f2,-98|-3|0xf2f2f2", 90, 0, 0, 749,  1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x,y,8)
			mSleep(math.random(500, 700))
			toast("不是我的，继续注册3",1)
		end

		mSleep(math.random(500, 700))
		if getColor(492, 1266) == 0x576b95 and getColor(561, 1262) == 0x576b95 then
			toast("封号1",1)
			break
		end

		mSleep(math.random(500, 700))
		if getColor(346, 803) == 0x576b95 and getColor(390, 796) == 0x576b95 then
			toast("封号2",1)
			break
		end

		mSleep(math.random(500, 700))
		if getColor(362,797) == 0x576b95 and getColor(391,800) == 0x576b95 then
			toast("账号状态异常",1)
			break
		end

		mSleep(math.random(500,700))
		x, y = findMultiColorInRegionFuzzy(0x576b95,"-27|-1|0x576b95,-261|-189|0,-225|-188|0,173|-182|0,-218|219|0x36030,158|207|0x36030", 90, 0, 0, 749,  1333)
		if x~=-1 and y~=-1 then
			mSleep(math.random(500, 700))
			randomsTap(x,y,8)
			mSleep(math.random(1500, 2700))
			randomsTap(384,1131,6)
			mSleep(4000)
			not_get_code = not_get_code + 1
			if not_get_code > 2 then
				goto over
			else
				toast("尚未收到短信"..not_get_code,1)
			end
		end

		mSleep(500)
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "-28|3|0x576b95,-136|-177|0x000000,-66|-179|0x000000,54|-175|0x000000,199|-180|0x000000", 90, 0, 0, 749, 1333)
		if x~=-1 and y~=-1 then
			mSleep(500)
			if fz_type == "3" then
				goto run_app
			else
				goto over
			end

		end
	end
	mSleep(12000)
	error_bool = false
	get_wechatError_six = false
	while (true) do
		--通讯录匹配
		mSleep(math.random(500, 700))
		x,y = findMultiColorInRegionFuzzy( 0x576b95, "4|13|0x576b95,14|-4|0x576b95,14|6|0x576b95,18|18|0x576b95", 90, 0, 0, 645,  845)
		if x~=-1 and y~=-1 then
			mSleep(500)
			get_six_two = true
			toast("账号存活",1)
			break
		end

		mSleep(math.random(500, 700))
		x, y = findMultiColorInRegionFuzzy(0x1565fc,"1|14|0x1565fc,12|-4|0x1565fc,16|6|0x1565fc,12|21|0x1565fc,-174|-247|0", 90, 0, 0, 645,  845)
		if x~=-1 and y~=-1 then
			mSleep(500)
			get_six_two = true
			toast("账号存活",1)
			break
		end

		mSleep(math.random(500, 700))
		if getColor(492, 1266) == 0x576b95 and getColor(561, 1262) == 0x576b95 then
			mSleep(500)
			randomsTap(362,797,4)
			mSleep(500)
			toast("封号1",1)
			error_bool = true
			get_wechatError_six = true
			break
		end

		mSleep(math.random(500, 700))
		if getColor(346, 803) == 0x576b95 and getColor(390, 796) == 0x576b95 then
			mSleep(500)
			randomsTap(362,797,4)
			mSleep(500)
			toast("封号2",1)
			error_bool = true
			get_wechatError_six = true
			break
		end

		mSleep(math.random(500, 700))
		if getColor(362,797) == 0x576b95 and getColor(391,800) == 0x576b95 then
			mSleep(500)
			randomsTap(362,797,4)
			mSleep(500)
			toast("账号状态异常",1)
			error_bool = true
			get_wechatError_six = true
			break
		end
	end

	if get_six_two or get_wechatError_six then
		function getData()  ----单线程提取
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
							for i = 3 ,5 do
								if tonumber(v[i]) then
									wx = v[i]
									wxid = v[i-1]
									break
								end	
							end	
						end	
					end	
					--dialog(wxid.."\r\n"..wx, time)
					nLog(Wildcard[var])
					local str = file:read("*a")
					file:close()
					require"sz"
					local str = string.tohex(str) --16进制编码
					return str
				end 
			end 
		end

		function _追加写入(path,nr1,nr2,nr3,nr4,nr5,nr6,nr7)     ---以追加的方式写入文本，path是路径，nr是要写入的内容，自动换行
			local path = userPath().."/res/"..path
			if nr1 == nil then
				dialog("没有要存入的内容", time)
			end	
			local nr2 = nr2 or ""
			local nr3 = nr3 or ""
			local nr4 = nr4 or ""
			local nr5 = nr5 or ""
			local nr6 = nr6 or ""
			local nr7 = nr7 or ""
			local 文件句柄 = io.open(path,"a")
			local 文件 = 文件句柄:write(nr1,nr2,nr3,nr4,nr5,nr6,nr7)   
			local 文件 = 文件句柄:write("\n")   
			文件句柄:close()
			local 文件句柄 = io.open(path,"r")
			local 文件 = 文件句柄:read("*all")
			toast(文件,5)
			文件句柄:close()
		end

		function _自定义提取62数据流程(fz_type,get_wechatError_six,ip)
			local data = getData()
			if data then
				if wx_id == "提取wx_id" then
					_追加写入("备用读取62数据.txt",wxid,"----",data)
					mSleep(math.random(1000, 1500))
					toast("提取成功！",1)
				else
					_追加写入("备用读取62数据.txt",wx,"----",data)
					mSleep(math.random(1000, 1500))
					toast("提取成功！",1)
				end	
			else
				dialog("提取失败！", 1)
			end	
			local ts = require("ts")
			time = getNetTime()    
			now = os.date("%Y年%m月%d日%H点%M分%S秒",time) 
			mSleep(math.random(500, 700))

			if fz_type == "3" then
				ip = "null"
			else
				mSleep(500)
				if type(ip) ~= "boolean" then
					toast(ip,1)
					mSleep(1000)
				else
					ip = "huoqushibai"
				end
			end

			if get_wechatError_six then
				toast("写入异常数据",1)
				if api_change == "7" then
					all_data = wx.."----"..password.."----"..data.."----"..wxid.."----"..ip.."======MiaoFeng----"..now.."----"..urlEncoder(codeUrl)
				else
					all_data = wx.."----"..password.."----"..data.."----"..wxid.."----"..ip.."======MiaoFeng----"..now.."----null"
				end
				status = ts.hlfs.makeDir("/private/var/mobile/Media/TouchSpriteENT/res/秒封62数据") --新建文件夹
				writeFileString(userPath().."/res/秒封62数据/62数据wxid.txt",wxid.."----"..password.."----"..data.."----"..now,"a",1) --将 string 内容存入文件，成功返回 true
				writeFileString(userPath().."/res/秒封62数据/62数据手机号.txt",all_data,"a",1) --将 string 内容存入文件，成功返回 true
				mSleep(1000)
			else
				toast("写入正常数据",1)
				if api_change == "7" then
					all_data = wx.."----"..password.."----"..data.."----"..wxid.."----"..ip.."----"..now.."----"..urlEncoder(codeUrl)
				else
					all_data = wx.."----"..password.."----"..data.."----"..wxid.."----"..ip.."----"..now.."----null"
				end
				status = ts.hlfs.makeDir("/private/var/mobile/Media/TouchSpriteENT/res/62数据") --新建文件夹
				writeFileString(userPath().."/res/62数据/62数据wxid.txt",wxid.."----"..password.."----"..data.."----"..now,"a",1) --将 string 内容存入文件，成功返回 true
				writeFileString(userPath().."/res/62数据/62数据手机号.txt",all_data,"a",1) --将 string 内容存入文件，成功返回 true
				mSleep(1000)
			end
			::send::
			local sz = require("sz")       
			local http = require("szocket.http")
			local res, code = http.request("http://47.104.246.33/account.php?time="..time.."&info="..all_data)

			if code == 200 then
				mSleep(500)
				toast("数据上传"..res,1)
				mSleep(1000)
			else
				toast("重新上传",1)
				mSleep(1000)
				goto send
			end
		end

		_自定义提取62数据流程(fz_type,get_wechatError_six,ip)
		if request_ipWay == "1" then
			::areaId::
			local sz = require("sz");
			local http = require("szocket.http")
			local res, code = http.request("http://cardapi.mabang18.com/mbapi/generic/getprovincesort")
			nLog(res)
			if code == 200 then
				tmp = json.decode(res)
				if #tmp.data > 3 then
					areaId = math.random(1, 3)
				else
					areaId = math.random(1, #tmp.data)
				end
				place_id = tmp.data[areaId].areaId
				toast(place_id,1)
				mSleep(1000)
			else
				goto areaId
			end
		end

		if fz_success_bool then
			if fz_type == "5" then
				--标记订单
				::bj::
				local sz = require("sz");
				local http = require("szocket.http")
				local res, code = http.request("http://api.tvnxl.com/xd/xg?key="..fz_key.."&oId="..old.."&sts=success")

				if code == 200 then
					tmp = json.decode(res)
					if tmp.success then
						toast("订单标记："..tmp.data, 1)
						mSleep(3000)
					else
						toast("标记失败:"..res,1)
						mSleep(2000)
						goto bj
					end
				end
			elseif fz_type == "6" then
				::push_work::
				header_send = {
				}
				body_send = string.format("order_sn=%s&status=%s&merchant=%s",order_sn,"1",fz_key)
				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/change.action", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.code == "200" then
						mSleep(1000)
						toast("标记成功",1)
					else
						toast("标记失败:"..body_resp,1)
						mSleep(2000)
						goto push_work
					end
				else
					toast("标记失败:"..body_resp,1)
					mSleep(2000)
					goto push_work
				end
			elseif fz_type == "8" then 
				::push_work::
				header_send = {}
				body_send = string.format("userKey=%s&orderId=%s&status=%s",fz_key,taskId,1)

				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					elseif tmp.msg == "已提交任务结果" then
						toast("订单可能未接单退款了："..tmp.msg,1)
						mSleep(2000)
					else
						goto push_work
					end
				else
					goto push_work
				end
			elseif fz_type == "9" then
				::push_work::
				header_send = {}
				body_send = string.format("userKey=%s&orderId=%s&status=%s",sumbit_key,taskId,1)
				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					elseif tmp.msg == "已提交任务结果" then
						toast("订单可能未接单退款了："..tmp.msg,1)
						mSleep(2000)
					elseif tmp.code == 1 then
						toast(tmp.msg,1)
						mSleep(2000)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					toast(body_resp,1)
					mSleep(3000)
					goto push_work
				end
			elseif fz_type == "10" then
				::push_work::
				header_send = {}
				body_send = string.format("key=%s&oId=%s&sts=%s",sumbit_key,oId,"success")
				ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
				status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/xg", header_send, body_send, true)
				if status_resp == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					elseif tmp.code == "3" or tmp.code == "4" or tmp.code == "5" or tmp.code == "7" or tmp.code == "6" then
						toast(tmp.msg,1)
						mSleep(2000)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					toast(body_resp,1)
					mSleep(3000)
					goto push_work
				end
			elseif fz_type == "11" then
				::push_work::
				header_send = {
					["Content-Type"] = "application/x-www-form-urlencoded",
				}
				body_send = {
					["userKey"] = sumbit_key,
					["orderId"] = orderId,
					["status"] = 1,
				}
				ts.setHttpsTimeOut(60)
				code,header_resp, body_resp = ts.httpsPost("http://api.qianxing666.com/api/open-api/orders/mark", header_send,body_send)
				if code == 200 then
					local tmp = json.decode(body_resp)
					if tmp.success then
						toast("标记成功",1)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					toast(body_resp,1)
					mSleep(3000)
					goto push_work
				end
			elseif fz_type == "12" then
				::push_work::
				header_send = {token=string.format("%s", sumbit_key)}
				
				body_send = string.format("taskId=%s&status=%s", taskId, 2)
				ts.setHttpsTimeOut(60) -- 安卓不支持设置超时时间
				code,header_resp, body_resp = ts.httpPost("https://pu.xgtask.com/api/task/status", header_send,body_send)
				if code == 200 then
					mSleep(500)
					local tmp = json.decode(body_resp)
					if tmp.code == 200 then
						toast("标记成功",1)
					elseif tmp.message == "任务已被标记为成功" or tmp.message == "任务已被标记为失败" then
						toast("已经标记过该任务",1)
					else
						toast(body_resp,1)
						mSleep(3000)
						goto push_work
					end
				else
					goto push_work
				end
			end
		end

		get_six_two = false
		if login_times == "1" then
			data_sel = readFile(userPath().."/res/data_sel.txt")
			account_len = tonumber(data_sel[1]) + 1
			if account_len >= tonumber(login_times_set) then
				toast(login_times_set.."个注册完成",1)
				writeFileString(userPath().."/res/data_sel.txt","0","w",0) --将 string 内容存入文件，成功返回 true
				goto over
			else
				toast("第"..account_len.."个注册完成",1)
				mSleep(150)
				writeFileString(userPath().."/res/data_sel.txt",tostring(account_len),"w",0) --将 string 内容存入文件，成功返回 true
				mSleep(500)
				if not get_wechatError_six then
					while true do
						mSleep(math.random(500, 700))
						x, y = findMultiColorInRegionFuzzy(0x1565fc,"1|14|0x1565fc,12|-4|0x1565fc,16|6|0x1565fc,12|21|0x1565fc,-174|-247|0", 90, 0, 0, 749, 1333)
						if x~=-1 and y~=-1 then
							mSleep(500)
							randomsTap(x,y,5)
							mSleep(500)
						end

						mSleep(math.random(500, 700))
						if getColor(363,813) == 0x576b95 and getColor(382,820) == 0x576b95 then
							mSleep(500)
							randomsTap(363,813,4)
							mSleep(500)
						end

						mSleep(500)
						if getColor(654,1279) == 0x7c160 then
							mSleep(500)
							while true do
								mSleep(500)
								x, y = findMultiColorInRegionFuzzy(0x1485ee,"64|11|0x191919,78|6|0x191919,99|11|0x191919,116|11|0x191919,108|12|0x4a4a4a,2|13|0x1485ee", 90, 0, 600, 749, 1333)
								if x~=-1 and y~=-1 then
									mSleep(500)
									randomsTap(x+300,y+50,5)
									mSleep(500)
									break
								end
							end
							mSleep(1000)
							toast("我的",1)
							break
						else
							mSleep(500)
							randomTap(654,1279,2)
							mSleep(500)
						end

						mSleep(math.random(500, 700))
						if getColor(492, 1266) == 0x576b95 and getColor(561, 1262) == 0x576b95 then
							mSleep(500)
							randomsTap(362,797,4)
							mSleep(500)
							toast("封号1,超过判断12秒时间，账号写入正常列表",1)
							goto fh
						end

						mSleep(math.random(500, 700))
						if getColor(346, 803) == 0x576b95 and getColor(390, 796) == 0x576b95 then
							mSleep(500)
							randomsTap(362,797,4)
							mSleep(500)
							toast("封号2,超过判断12秒时间，账号写入正常列表",1)
							goto fh
						end

						mSleep(math.random(500, 700))
						if getColor(362,797) == 0x576b95 and getColor(391,800) == 0x576b95 then
							mSleep(500)
							randomsTap(362,797,4)
							mSleep(500)
							toast("账号状态异常,超过判断12秒时间，账号写入正常列表",1)
							goto fh
						end

					end

					while true do
						mSleep(500)
						if getColor(356,1167) == 0x191919 then
							mSleep(500)
							tap(356,1167)
							mSleep(500)
						end

						mSleep(500)
						if getColor(356,1172) == 0xe64340 then
							mSleep(500)
							tap(356,1172)
							mSleep(500)
							break
						end

					end
					get_wechatError_six = false
				end

				::fh::
				if fz_type == "3" then
					mSleep(500)
					closeApp(self.wc_bid, 0)
					mSleep(5000)
					setVPNEnable(false)
					setVPNEnable(false)
					mSleep(1000)
					runApp(self.wc_bid)
					mSleep(2000)
				end

				while true do
					mSleep(math.random(500, 700))
					if getColor(561,1265) == 0x576b95 then
						mSleep(math.random(500, 700))
						randomsTap(542,1273,3)
						mSleep(math.random(500, 700))
					end

					if getColor(393,1170) == 0 then
						mSleep(math.random(500, 700))
						randomsTap(393,1170,3)
						mSleep(math.random(500, 700))
						break
					end
				end
				next_again_time_bool = true
				goto start
			end
		else
			while true do
				mSleep(math.random(500, 700))
				x, y = findMultiColorInRegionFuzzy(0x1565fc,"1|14|0x1565fc,12|-4|0x1565fc,16|6|0x1565fc,12|21|0x1565fc,-174|-247|0", 90, 0, 0, 749, 1333)
				if x~=-1 and y~=-1 then
					mSleep(500)
					randomsTap(x,y,5)
					mSleep(500)
					break
				end
			end
			self:idCard()
		end
	end

	::over::
	if new_bool then
		mSleep(500)
		closeApp(self.wc_bid, 0)
		mSleep(5000)
		setVPNEnable(false)
		setVPNEnable(false)
		mSleep(1000)
	end

	if fz_type == "5" then
		::check::
		local sz = require("sz");
		local http = require("szocket.http")
		local res, code = http.request("http://www.tvnxl.com/xd/cx?key="..fz_key.."&oId="..old)
		if code == 200 then
			tmp = json.decode(res)
			if tmp.success then
				if tmp.data.sts == 4 then
					wjd_bool = true
				else
					wjd_bool = false
				end
			else
				toast(res,1)
				mSleep(2000)
				goto check
			end
		else
			toast(res,1)
			mSleep(2000)
			goto check
		end

		--标记订单
		if not send_fm_bool and not ewm_url_bool and not wjd_bool then
			::bj::
			local sz = require("sz");
			local http = require("szocket.http")
			local res, code = http.request("http://api.tvnxl.com/xd/xg?key="..fz_key.."&oId="..old.."&sts=fail")
			if code == 200 then
				tmp = json.decode(res)
				if tmp.success then
					toast("订单标记："..tmp.data, 1)
					mSleep(3000)
				else
					toast(body_resp,1)
					mSleep(5000)
					goto bj
				end
			end
		end
	elseif fz_type == "6" then
		::check::
		header_send = {
		}
		body_send = string.format("order_sn=%s&merchant=%s",order_sn,fz_key)
		ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
		status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/query.action", header_send, body_send, true)
		if status_resp == 200 then
			local tmp = json.decode(body_resp)
			if tmp.code == "200" then
				if tmp.data.status == 4 then
					wjd_bool = true
				else
					wjd_bool = false
				end
			elseif tmp.code == "800" then
				wjd_bool = true
			else
				toast(res,1)
				mSleep(2000)
				goto check
			end
		else
			toast(res,1)
			mSleep(2000)
			goto check
		end

		if not send_fm_bool and not ewm_url_bool and not wjd_bool then
			::push_work::
			header_send = {
			}
			body_send = string.format("order_sn=%s&status=%s&merchant=%s",order_sn,"2",fz_key)
			ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
			status_resp, header_resp, body_resp  = ts.httpPost("http://api.004461.cn/change.action", header_send, body_send, true)
			if status_resp == 200 then
				local tmp = json.decode(body_resp)
				if tmp.code == "200" then
					toast("标记成功",1)
				elseif tmp.message == "任务已标记，请勿重复标记" then
					toast(tmp.message,1)
					mSleep(1000)
				else
					toast(body_resp,1)
					mSleep(5000)
					goto push_work
				end
			else
				toast(body_resp,1)
				mSleep(2000)
				goto push_work
			end
		end
	elseif fz_type == "8" then
		::push_work::
		header_send = {}
		body_send = string.format("userKey=%s&orderId=%s&status=%s",fz_key,taskId,2)
		ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
		status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
		if status_resp == 200 then
			local tmp = json.decode(body_resp)
			if tmp.success then
				toast("标记成功",1)
			elseif tmp.msg == "已提交任务结果" then
				toast("订单可能未接单退款了："..tmp.msg,1)
				mSleep(2000)
			elseif tmp.code == 1 then
				toast(tmp.msg,1)
				mSleep(2000)
			else
				toast("标记失败，重新标记："..body_resp,1)
				mSleep(8000)
				goto push_work
			end
		else
			toast("标记失败，重新标记："..body_resp,1)
			mSleep(8000)
			goto push_work
		end
	elseif fz_type == "9" then
		::push_work::
		header_send = {}
		body_send = string.format("userKey=%s&orderId=%s&status=%s",sumbit_key,taskId,2)
		ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
		status_resp, header_resp, body_resp  = ts.httpPost("http://cardapi.mabang18.com/mbapi/order/mark", header_send, body_send, true)
		if status_resp == 200 then
			local tmp = json.decode(body_resp)
			if tmp.success then
				toast("标记成功",1)
			elseif tmp.msg == "已提交任务结果" then
				toast("订单可能未接单退款了："..tmp.msg,1)
				mSleep(2000)
			elseif tmp.code == 1 then
				toast(tmp.msg,1)
				mSleep(2000)
			else
				toast(body_resp,1)
				mSleep(3000)
				goto push_work
			end
		else
			toast(body_resp,1)
			mSleep(3000)
			goto push_work
		end
	elseif fz_type == "10" then
		::push_work::
		header_send = {}
		body_send = string.format("key=%s&oId=%s&sts=%s",sumbit_key,oId,"fail")
		ts.setHttpsTimeOut(60)--安卓不支持设置超时时间 
		status_resp, header_resp, body_resp  = ts.httpPost("http://api.tvnxl.com/xd/xg", header_send, body_send, true)
		if status_resp == 200 then
			local tmp = json.decode(body_resp)
			if tmp.success then
				toast("标记成功",1)
			elseif tmp.code == "3" or tmp.code == "4" or tmp.code == "5" or tmp.code == "7" or tmp.code == "6" then
				toast(tmp.msg,1)
				mSleep(2000)
			else
				toast(body_resp,1)
				mSleep(3000)
				goto push_work
			end
		else
			toast(body_resp,1)
			mSleep(3000)
			goto push_work
		end
	elseif fz_type == "11" then
		::push_work::
		header_send = {
			["Content-Type"] = "application/x-www-form-urlencoded",
		}
		body_send = {
			["userKey"] = sumbit_key,
			["orderId"] = orderId,
			["status"] = 2,
		}
		ts.setHttpsTimeOut(60)
		code,header_resp, body_resp = ts.httpsPost("http://api.qianxing666.com/api/open-api/orders/mark", header_send,body_send)
		if code == 200 then
			local tmp = json.decode(body_resp)
			if tmp.success then
				toast("标记成功",1)
			else
				toast(body_resp,1)
				mSleep(3000)
				goto push_work
			end
		else
			toast(body_resp,1)
			mSleep(3000)
			goto push_work
		end
	elseif fz_type == "12" then
		::push_work::
		header_send = {token=string.format("%s", sumbit_key)}
		
		body_send = string.format("taskId=%s&status=%s", taskId, 3)
		ts.setHttpsTimeOut(60) -- 安卓不支持设置超时时间
		code,header_resp, body_resp = ts.httpPost("https://pu.xgtask.com/api/task/status", header_send,body_send)
		if code == 200 then
			mSleep(500)
			local tmp = json.decode(body_resp)
			if tmp.code == 200 then
				toast("标记成功",1)
			elseif tmp.message == "任务已被标记为成功" or tmp.message == "任务已被标记为失败" then
				toast("已经标记过该任务",1)
			else
				toast(body_resp,1)
				mSleep(3000)
				goto push_work
			end
		else
			goto push_work
		end
	end

	phone_loginTime = readFile(userPath().."/res/phone_loginTime.txt")
	if tonumber(phone_loginTime[1]) < tonumber(fz_error_times) then
		if not clean_bool then
			if api_change == "2" or api_change == "6" or api_change == "7" then
				mSleep(500)
				randomsTap(55,83,3)
				mSleep(500)
				setVPNEnable(false)
				if vpn_country == "0" then
					self:changeGNIP(place_id,iptimes)
				elseif vpn_country == "1" then
					self:changeGWIP(ip_country)
				end
				setVPNEnable(true)
				againLogin_bool = true
				if api_change == "2" then
					goto aodi
				else
					goto next_again
				end
			end
		else
			writeFileString(userPath().."/res/phone_data.txt","","w",0)
		end
	else
		if api_change == "2" and not clean_bool then
			::addblack::
			local sz = require("sz")        --登陆
			local http = require("szocket.http")
			local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=addBlack&token="..phone_token.."&pid="..pid.."&reason="..urlEncoder("获取失败"))
			mSleep(500)
			if code == 200 then
				data = strSplit(res, "|")
				if data[1] == "1" then
					toast("拉黑手机号码",1)
				else
					goto addblack
				end
			end
		elseif api_change == "7" and not clean_bool then
			::push::
			mSleep(500)
			local sz = require("sz")        --登陆
			local http = require("szocket.http")
			local res, code = http.request("http://47.104.246.33/phone.php?cmd=poststatus&phone="..phone.."&status=失败")
			mSleep(500)
			if code == 200 then
				if reTxtUtf8(res) == "反馈成功" then
					toast("号码状态标记成功",1)
				else
					goto push
				end
			else
				toast("标记失败，重新标记",1)
				mSleep(3000)
				goto push
			end
		end
		writeFileString(userPath().."/res/phone_data.txt","","w",0)
	end
	::gg::
	setVPNEnable(false)
end

function model:main()
	if getSixData == "0" then
		local m = TSVersions()
		if m <= "1.2.7" then
			dialog("请使用 v1.2.8 及其以上版本 TSLib",0)
			luaExit()
		else
			ts_version = ts.version()
			toast("TSLib版本为："..m.."\r\nts.so版本为："..ts_version,1)
		end

		if fz_type == "1" then
			if fz_key == "" or fz_key == "默认值" then
				dialog("设置正确的辅助key", 3)
				lua_restart()
			end
			if fz_province == "" or fz_province == "默认值" then
				dialog("设置正确的辅助省份", 3)
				lua_restart()
			end
		end

		if api_change == "1" then
			if SMS_country == "" or SMS_country == "默认值" then
				dialog("设置正确的SMS国家代码", 3)
				lua_restart()
			end
		end

		if api_change == "2" or api_change == "3" then
			if username == "" or username == "默认值" then
				dialog("账号不能为空", 3)
				lua_restart()
			end
			if user_pass == "" or user_pass == "默认值" then
				dialog("密码不能为空", 3)
				lua_restart()
			end
			if work_id == "" or work_id == "默认值" then
				dialog("项目id不能为空", 3)
				lua_restart()
			end
		end

		if password == "" or password == "默认值" then
			dialog("密码不能为空，请重新运行脚本设置密码", 3)
			lua_restart()
		end

		if getPhone_key == "" or getPhone_key == "默认值" then
			dialog("接码key不能为空，请设置key", 3)
			lua_restart()
		end

		if sumbit_key == "" or sumbit_key == "默认值" then
			dialog("辅助key不能为空，请设置key", 3)
			lua_restart()
		end

		if api_change == "2" then
			::get_token::
			local sz = require("sz");
			local http = require("szocket.http")
			local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=login&ApiName="..username.."&PassWord="..user_pass)
			if code == 200 then
				data = strSplit(res,"|")
				if data[1] == "1" then
					phone_token = data[2]
					toast(phone_token,1)
				else
					goto get_token
				end
			else
				goto get_token
			end
		end

		if request_ipWay == "1" then
			::areaId::
			local sz = require("sz");
			local http = require("szocket.http")
			local res, code = http.request("http://cardapi.mabang18.com/mbapi/generic/getprovincesort")
			nLog(res)
			if code == 200 then
				tmp = json.decode(res)
				if #tmp.data > 3 then
					areaId = math.random(1, 3)
				else
					areaId = math.random(1, #tmp.data)
				end
				place_id = tmp.data[areaId].areaId
				toast(place_id,1)
				mSleep(1000)
			else
				goto areaId
			end
		end

		mSleep(500)
		setVPNEnable(false)
		mSleep(2000)
		get_six_two = false
		while true do
			if vpn_country == "0" then
				mSleep(500)
				runApp("com.liguangming.Shadowrocket")
				while true do
					mSleep(500)
					if getColor(547,101) == 0x2473bd then
						mSleep(500)
						tap(365,579)
						mSleep(3000)
						break
					end

					mSleep(500)
					if getColor(547,101) == 0x4386c5 then
						mSleep(500)
						tap(365,630)
						mSleep(3000)
						break
					end
				end
			elseif vpn_country == "1" then
				mSleep(500)
				runApp("com.liguangming.Shadowrocket")
				while true do
					mSleep(500)
					if getColor(547,101) == 0x2473bd then
						mSleep(500)
						tap(365,670)
						mSleep(2000)
						break
					end

					mSleep(500)
					if getColor(547,101) == 0x4386c5 then
						mSleep(500)
						tap(365,710)
						mSleep(2000)
						break
					end
				end
			elseif vpn_country == "2" then
				self:service_GWvpn()
			elseif vpn_country == "3" then
				self:service_GNvpn()
			end

			if login_times == "1" then
				data_sel = readFile(userPath().."/res/data_sel.txt")
				toast(data_sel[1],1)
				if data_sel[1] == "0" then
					self:clear_App()
				end
				writeFileString(userPath().."/res/phone_data.txt","","w",0)
			else
				::file::
				bool = self:file_exists(userPath().."/res/phone_data.txt")
				if bool then
					phone_data = readFile(userPath().."/res/phone_data.txt")
					toast(phone_data[1],1)
					if type(phone_data[1]) ~= "nil" then
						toast("号码文件有号码，不新机",1)
					else
						writeFileString(userPath().."/res/phone_data.txt","","w",0)
						self:clear_App()
					end
				else
					writeFileString(userPath().."/res/phone_data.txt","","w",0)
					goto file
				end
			end
			self:wechat(fz_error_times,iptimes,ip_country,place_id,data_sel,login_times,login_times_set,skey,wc_version,hk_way,fz_key, fz_type, phone, country_num, phone_token, api_change, SMS_country, username, user_pass, work_id, phone_country, country_id,nickName,password,provinceId,getPhone_key, sumbit_key,messGetTime,messSendTime)
			mSleep(1000)
		end
	else
		function getData()  ----单线程提取
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
							for i = 3 ,5 do
								if tonumber(v[i]) then
									wx = v[i]
									wxid = v[i-1]
									break
								end	
							end	
						end	
					end	
					--dialog(wxid.."\r\n"..wx, time)
					nLog(Wildcard[var])
					local str = file:read("*a")
					file:close()
					require"sz"
					local str = string.tohex(str) --16进制编码
					return str
				end 
			end 
		end

		function _追加写入(path,nr1,nr2,nr3,nr4,nr5,nr6,nr7)     ---以追加的方式写入文本，path是路径，nr是要写入的内容，自动换行
			local path = userPath().."/res/"..path
			if nr1 == nil then
				dialog("没有要存入的内容", 0)
			end	
			local nr2 = nr2 or ""
			local nr3 = nr3 or ""
			local nr4 = nr4 or ""
			local nr5 = nr5 or ""
			local nr6 = nr6 or ""
			local nr7 = nr7 or ""
			local 文件句柄 = io.open(path,"a")
			local 文件 = 文件句柄:write(nr1,nr2,nr3,nr4,nr5,nr6,nr7)   
			local 文件 = 文件句柄:write("\n")   
			文件句柄:close()
			local 文件句柄 = io.open(path,"r")
			local 文件 = 文件句柄:read("*all")
			toast(文件,5)
			文件句柄:close()
		end

		function _自定义提取62数据流程()
			local data = getData()
			if data then
				if wx_id == "提取wx_id" then
					_追加写入("备用读取62数据.txt",wxid,"----",data)
					mSleep(math.random(1000, 1500))
					toast("提取成功！",1)
				else
					_追加写入("备用读取62数据.txt",wx,"----",data)
					mSleep(math.random(1000, 1500))
					toast("提取成功！",1)
				end	
			else
				dialog("提取失败！", 1)
			end	
			local ts = require("ts")
			time = getNetTime()    
			now = os.date("%Y年%m月%d日%H点%M分%S秒",time) 
			mSleep(math.random(500, 700))

			ip = "null"
			
			toast("写入正常数据",1)
			all_data = wx.."----111111111----"..data.."----"..wxid.."----"..ip.."----"..now.."----null"
			
			status = ts.hlfs.makeDir("/private/var/mobile/Media/TouchSpriteENT/res/62数据") --新建文件夹
			writeFileString(userPath().."/res/62数据/62数据wxid.txt",wxid.."----111111111----"..data.."----"..now,"a",1) --将 string 内容存入文件，成功返回 true
			writeFileString(userPath().."/res/62数据/62数据手机号.txt",all_data,"a",1) --将 string 内容存入文件，成功返回 true
			mSleep(1000)
			
			::send::
			local sz = require("sz")       
			local http = require("szocket.http")
			local res, code = http.request("http://47.104.246.33/account.php?time="..time.."&info="..all_data)

			if code == 200 then
				mSleep(500)
				toast("数据上传"..res,1)
				mSleep(1000)
			else
				toast("重新上传",1)
				mSleep(1000)
				goto send
			end
		end
		
		_自定义提取62数据流程()
	end
end

function beforeUserExit()
	mSleep(500)
	setVPNEnable(false)
	mSleep(2000)
	writeFileString(userPath().."/res/phone_data.txt","","w",0)
	if api_change == "2" then
		::addblack::
		local sz = require("sz")        --登陆
		local http = require("szocket.http")
		local res, code = http.request("http://www.3cpt.com/yhapi.ashx?act=addBlack&token="..phone_token.."&pid="..pid.."&reason="..urlEncoder("获取失败"))
		mSleep(500)
		if code == 200 then
			data = strSplit(res, "|")
			if data[1] == "1" then
				toast("拉黑手机号码",1)
			else
				goto addblack
			end
		end
	end
end

model:main()