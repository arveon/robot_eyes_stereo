function x = disp_map(imf, ims)
    [imf_width, imf_height] = size(imf);
    sg_size = [5 7];
    sw_size = [15 7];
    
    disp=zeros(imf_width,imf_height);
    disp(:,:)=-1;
    half_sg_width=floor(sg_size(1)/2);
    half_sw_width=floor(sw_size(1)/2);
    half_sg_height=floor(sg_size(2)/2);
    half_sw_height=floor(sw_size(2)/2);
    
    for y = 1+half_sg_height : imf_height-half_sg_height
        %calculate Y coordinate for segment
        lowy=y-half_sg_height;
        highy=y+half_sg_height;
        if lowy < 1
            lowy = 1;
        end
        if highy > imf_height
            highy=imf_height;
        end
        
        %calculate Y coordinate for search window
        swlowy=y-half_sw_height;
        swhighy=y+half_sw_height;
        if swlowy < 1
%              dif=abs(swlowy - 1);
%              swhighy = swhighy+dif;
            swlowy = 1;
        end
        if swhighy > imf_height
%                 dif=abs(swhighy-imf_height);
%                 swlowy=swlowy-dif;
            swhighy=imf_height;
        end
            
        for x = 1+half_sg_width : imf_width-half_sg_width         
            %calculate X coodrinate for segment
            lowx=x-half_sg_width;
            highx=x+half_sg_width;
            
            if highx > imf_width 
                highx = imf_width;
            end
            if lowx < 1
                lowx = 1;
            end
            seg=imf(lowy:highy-1, lowx:highx-1);
%             imshow(seg);
            %calculate X coodrinate for search window
            swlowx=x-half_sw_width;
            swhighx=x+half_sw_width;
            
            if swhighx > imf_width 
%                 dif=abs(swhighx-imf_width);
%                 swlowx=swlowx-dif;
                swhighx = imf_width;
            end
            if swlowx < 1
%                 dif=abs(swlowx - 1);
%                 swhighx = swhighx+dif;
                swlowx = 1;
            end
            search_window = ims(swlowy:swhighy, swlowx:swhighx);
%              imshow(search_window);
%             size(search_window)
%             subplot(1,2,1), imshow(seg,[]), title("seg");
%             subplot(1,2,2), imshow(search_window,[]), title("win");
            
%             imshow(search_window);
% disp returns coordinates within search window
            res=pixel_disp(seg, search_window);
            dx=x - (swlowx + res(1));
            disp(y,x)= dx;
%             disp(y,x)
%             clc
            
%             x
%              pause(2000);
%              break;
        end   
%          break;
        y
    end
    %normalise
    disp=disp-min(disp(:));
    disp=disp./max(disp(:));
    
    imshow(disp);
    imwrite(disp,"image.bmp");