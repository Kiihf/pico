pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--init
function _init()
hero = {}
col = {} -- colide position
max_colide_count = 2
hero.hp = 11
hero.x = 4*8
hero.y = 60*8
hero.sx = 1 -- speed
hero.sy = 1 -- speed
jump_power = 4
hero.on_flore = false
gravity = 0.3
time_damage = 0
second_save = 9
save_ef_speed = 21
save_form = false
color_save = 0
i = 0
max_frame = 3
speed = 5
end


-->8
--update
function _update()
key_control()
camera(hero.x-64,hero.y-64)
end


-->8
--draw
function _draw()
cls()
map(0,0,0,0,100,100)

if time_damage%2 == 0 then
pal(8,color_save)
else
pal()
end

_draw_hero()
draw_hero_hp()
end

function _draw_hero()
i += 1/speed
frame = 0
if hero.sy==0 then
frame = flr(i) % max_frame
end

sspr (frame*16,0,
16,16,
hero.x,hero.y-((2-frame)*2)+1,16,16,
sgn(hero.sx) == -1,false)
if i >= max_frame then
 i = 0
 end
end
-->8
--movement
function key_control()

if(btnp(⬆️) and
 (colx.x == nil or colx.x-(8*xd) > 4)
 and hero.sy == 0 
 and hero.on_flore) then
 hero.sy -= jump_power
end

col = dist_to_col(0,0,2)

if col.x  ~= nil and
col.x-(8*xd) <= hero.sx and
not save_form
 then
 hero.hp-=1
 save_form = true
end

if col.y  ~= nil and
col.y-(8*yd) <= hero.sy and
not save_form
 then
 hero.hp-=1
 save_form = true
end

time_damage = save_form and time_damage or save_ef_speed*second_save
if save_form then
time_damage = save_ef_speed*(second_save+last- time())
time_damage = flr(time_damage)
 if time_damage < 0 then
  save_form = false
  last = time()
  end
else
last = time()
end

hero.sy += gravity

hero_move()
end

function hero_move()

xd =flr((sgn(hero.sx)+1)/2)
yd =flr((sgn(hero.sy)+1)/2)

colx = dist_to_col(sgn(hero.sx),0,1)
colx2 = dist_to_col(-1*sgn(hero.sx),0,1)
coly = dist_to_col(0,sgn(hero.sy),1)

if coly.y ~= nil then
 hero.on_flore = sgn(hero.sy) == 1
 if coly.y <= hero.sy then
 hero.sy = -1*sgn(hero.sy)
 else
 coef = coly.y-(9*yd)
 coef = coef > 0 and coef or 0
 hero.sy = coef
  end
end

if colx.x  ~= nil and
colx.x-(8*xd) <= hero.sx and
colx2.x == nil
 then
  hero.sx *= -1
end

hero.x += hero.sx
hero.y += hero.sy
end

-->8
--colide
function dist_to_col(dir_x,dir_y,n)
local result = {}
c = {} -- colide position
c.x= 8*flr((hero.x+7)/8)+(dir_x*8)
c.y= 8*flr((hero.y+7)/8)+(dir_y*8)

for i=0,1,1 do
 for j=0,1,1 do
  if is_b(c.x+(8*i),c.y+(8*j),n)
  then
  buf = abs(c.x-hero.x+(8*i))-4
  result.x= min(buf,buf)
  buf = abs(c.y-hero.y+(8*j))-7
  result.y= min(buf,buf)
  return result
   end
  end
 end

 return result
end

function is_b(x,y,n) -- is block
map_n = mget(x/8,y/8)
return fget(map_n,n)
end
-->8
--hp
function draw_hero_hp()
  for i = 1,hero.hp do
    spr(12,hero.x-64+i*8+1*i,
                      hero.y-56)
  end
end
__gfx__
00008822000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008800880000000000000000000000000
0008288888090000000088220000000000008822000000000000000000000000000000000000000000000000000000008e888888000000000000000000000000
00a0208889900000000808888800000000080888880900000000000000000000000000000000000000000000000000008ee88888000000000000000000000000
0000908fbf00000000a020888999000000a020888990000000000000000000000000000000000000000000000000000088888888000000000000000000000000
000000ff3fe000000000908fbf0000000000908fbf00000000000000000000000000000000000000000000000000000088888888000000000000000000000000
000000ffff000000000000ff3fe00000000000ff3fe0000000000000000000000000000000000000000000000000000008888880000000000000000000000000
0000777777070000000000ffff000000000000ffff00000000000000000000000000000000000000000000000000000000888800000000000000000000000000
00000777777000000000777777000000000077777707000000000000000000000000000000000000000000000000000000088000000000000000000000000000
00008a88aa8000000000077777770000000007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008a88aaa8000000008a88aa80000000008a88aa80000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0008aa88aaaa800000008a88aaa8000000008a88aaa8000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000dffddd000000008aa88aaaa80000008aa88aaaa800000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000d000000d000000000dffddd0000000000dffddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000dddddd000000000d000000d00000000d000000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000d000000d000000000dddddd00000000dddddddddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dddddddddd000000dddddddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066060666
88888888000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f300000000000000000000000000000000000000f3f3f3f3f3f300000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000f3f3f3f3f3f3f3f3f3f3f30000000000000000f3f3f3f3000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000f30000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000f30000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000f30000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000f30000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000f30000000000000000000000f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000f300000000000000000000f3f30000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000f300000000000000000000f3000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f20000000000000000f3f3000000000000000000f30000000000000000000000000000f3f3f3f3f3f3f3f30000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f3f3f3000000000000f3f3000000000000000000f300000000000000f3f3f3f3f3f3f300000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f300000000000000000000000000000000000000f3f300000000000000000000000000f3000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f300000000000000000000000000000000000000f30000000000000000000000000000f3000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f300000000000000000000000000000000000000f30000000000000000000000000000f3000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f300000000000000000000000000000000000000f30000000000000000000000000000f3000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000f300000000000000000000000000000000000000f30000000000000000000000000000f3000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f2000000000000000000000000f300000000000000000000000000000000000000f30000000000000000000000000000f3000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f30000000000000000f2000000f300000000000000000000000000000000000000f3f300000000000000000000000000f3000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f300000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
00cc0000060700ffff0000ffff00ff3f3f3f3f3f3f3f00090a0000000000000000000000000000000000003f3f3f3f3f3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000001b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000ff00ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ff0000000000000000000000000000000000000000000000ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cc000000000000000000000000000000000000df00000000ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffff000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000ff00000000000000000000000000000000000000000000000000000000ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00ff0000ff00000000000000000000000000000000
0000000000000000000000000000000000000000000000000000df00000000000000000000000000000000000000000000000000000000000000ffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00ff000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000290000000000000000000000000000000000000000000000000000000000ff00ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff0000000000000000ffff00000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00000000000000000000000000000000000000000000000000000000000000000000000000000000ff00000000000000000000ff000000000000000000
000000000000000000000000000000000000000000000000000000df000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff0000ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000580000000055ff0000595a5b000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00ff000000000000000000000000000000000000000000000000000000ff00000000000000000000ff00000000000000000000
00000000000000000000000000000000000000000000000000ff0065ff6700006a6b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00ffffff000000000000000000000000000000000000000000000000000000000000000000ff00000000000000000000
00000000000000df0000000000000000000000000000000000ffdf7500000000007b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffff000000000000000000000000000000000000ff00000000000000000000ff0000000000000000000000
00000000000000000000000000000000000bcc00060008090aff0000ff000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000ff0000ffff00ff000000ffffffffdf160000191a1b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00000000000000000000ff000000000000000000000000
2aff00000000000000000000000000002a2b2425262728292a2b2425260000292a2b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00000000000000000000000000
3aff00000000000000000000000000003a3b3435363738393a3b3435360000393a3b0000000000000000c4c4c400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff000000000000000000ff0000000000000000000000000000
4aff00000000000000000000000000494a4b4445464748494a4b4445000000494a4b0000000000000000c4c4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff0000000000000000000000000000
5aff00000000000000000000000000595a5b5455565758595a5b5455000000005a5b0000000000000000c4c4c4c4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff0000000000000000ff000000000000000000000000000000
6aff0000000000000000000000000000000000000000000000000000000000006a6b000000000000000000c4c4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff0000000000000000ffff000000000000000000000000000000
7aff0000000000000000000000000000000000000000000000000000000000007a7b00000000000000000000c4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00000000000000ffff00000000000000000000000000000000
0aff003f00000000000000000000000000000000000000000000000000000000000000000000000000000000c4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff00000000000000ff0000000000000000000000000000000000
1aff003f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2aff003f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3aff003f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4aff00003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5aff00003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6aff00003f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000ffffffffff00000000ffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
