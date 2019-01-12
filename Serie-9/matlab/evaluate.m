function [out] = evaluate(datain,dataout,chkdatin,chkdatout,radius)
    %EVALUATE Summary of this function goes here
    %   Detailed explanation goes here
    out.system = genfis2(datain,dataout,radius);
    out.baseOut = evalfis(datain,out.system);
    out.chkOut = evalfis(chkdatin,out.system);
    out.baseQuality = norm(out.baseOut-dataout)/sqrt(length(out.baseOut));
    out.chkQuality = norm(out.chkOut-chkdatout)/sqrt(length(out.chkOut));
end

