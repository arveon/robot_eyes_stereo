function y = support_cmp(win_f, win_s, win_size)    
    %calculate the difference between pixels
    diff=imabsdiff(win_f, win_s);
    %get the sum of the differences (SAD) and return it
    y = sum(diff(:));








