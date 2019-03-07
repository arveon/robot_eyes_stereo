function y = support_cmp(win_f, win_s, win_size)
    [widthf, heightf, colf] = size(win_f);
    [widths, heights, cols] = size(win_s);
    
    if colf > 1
        win_f = rgb2gray(win_f);
    end
    
    if cols > 1
        win_s = rgb2gray(win_s);
    end
    
    if widthf ~= win_size || heightf ~= win_size
         win_f = win_f(1:win_size, 1:win_size, :);
    end

    if widths ~= win_size || heights ~= win_size
        win_s = win_s(1:win_size, 1:win_size, :);
    end
    
    diff=imabsdiff(win_f, win_s);
    y = sum(diff(:));








