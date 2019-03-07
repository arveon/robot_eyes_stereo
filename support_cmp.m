function y = support_cmp(win_f, win_s, win_size)
    %get dimensions of both windows
    [widthf, heightf, colf] = size(win_f);
    [widths, heights, cols] = size(win_s);
    
    %make sure both windows are grayscale
    if colf > 1
        win_f = rgb2gray(win_f);
    end    
    if cols > 1
        win_s = rgb2gray(win_s);
    end
    
    %make sure both windows are of same size, if not - crop them to
    %specified win size
    if widthf ~= win_size || heightf ~= win_size
         win_f = win_f(1:win_size, 1:win_size, :);
    end
    if widths ~= win_size || heights ~= win_size
        win_s = win_s(1:win_size, 1:win_size, :);
    end
    
    %calculate the difference between pixels
    diff=imabsdiff(win_f, win_s);
    %get the sum of the differences (SAD) and return it
    y = sum(diff(:));








