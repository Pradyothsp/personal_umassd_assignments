function ep = getEP(i)
if i < 400
    ep  = i/100;
elseif i < 4000
    ep = i/1000;
else
    ep = i/1250;
end
end