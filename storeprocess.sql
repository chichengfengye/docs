-- 需求：
-- 1. 接收两个时间
-- 2. 以第一个时间为起点，累加1天，每次都比较第二个时间，直到比第二个时间大停止，放到数组里。
-- 3. 遍历生成的数组，拼出查询统计sql语句
-- 4. 执行该语句

-- 实现
-- 第一步 传入两个long， 拼接成字符串返回
create or REPLACE FUNCTION jfsplitTime(time1 bigint , time2 bigint )
returns VARCHAR as $timestr$
DECLARE timestr VARCHAR;
BEGIN
	timestr:= concat('wewew_',time1, time2 ,'_test_');
	RETURN timestr;
end;
	$timestr$ LANGUAGE plpgsql;

-- 第二步 传入两个long， 返回一个数组，里面包含生成的两个timestamp
create or REPLACE FUNCTION returnArray(time1 bigint , time2 bigint )
returns TIMESTAMP[] as $timearr$
DECLARE 
	timearr TIMESTAMP[];
	timest1 TIMESTAMP;
	timest2 TIMESTAMP;			
BEGIN
	timest1 := to_timestamp(time1);
	timest2 := to_timestamp(time2);
	timearr := array_append(timearr, timest1);
	timearr := array_append(timearr, timest2);
RETURN timearr;
end;
	$timearr$ LANGUAGE plpgsql;
	
-- example three 传入两个long，分析出所有的天，放在数组里返回 这个现在有问题，还没做完 
drop function if EXISTS  returnIntArrInEachDay( bigint ,  bigint );
create or REPLACE FUNCTION returnIntArrInEachDay(time1 bigint , time2 bigint )
returns BIGINT [] as $intarr$
DECLARE 
	intarr BIGINT [];
	temploop BIGINT;
	tempTime BIGINT;
	intervalmills BIGINT;
BEGIN
		intervalmills :=  24* 60 * 60 * 1000;
		temploop := ceil((time2 - time1) / intervalmills);
		intarr:= array_append(intarr, time1);
		tempTime := time1;
		IF temploop > 1
		THEN
			FOR templong IN REVERSE 1..temploop LOOP
				tempTime := 123123123123    ;  
				intarr := array_append(intarr, tempTime);
			END LOOP;	
		ELSE
		END IF;
RETURN intarr;
end;
	$intarr$ LANGUAGE plpgsql;