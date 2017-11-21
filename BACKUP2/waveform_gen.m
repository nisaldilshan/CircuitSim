function output = waveform_gen(type, amplitude, offset, totaltime , T)
%     type = 2;
%     amplitude = 5;
%     offset = 5;
%     totaltime = 107;
%     T = 10;

    t =(totaltime/T) - floor(totaltime/T);
    if(type == 1)
        output = offset + (amplitude * sin(2*pi*t));
    elseif(type == 2)
        output = offset + (amplitude * square(2*pi*t));
    else
        output = amplitude;
    end
end