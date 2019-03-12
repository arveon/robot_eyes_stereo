function x = disp_map(imf, ims)
    [imf_width, imf_height] = size(imf);
    sg_size = 6;
    sw_size = 20;
    
    disp=zeros(imf_width,imf_height);
    disp(:,:)=-1;
    half_sg_size=floor(sg_size/2);
    half_sw_size=floor(sw_size/2);
    
%     figure;
%     hold on;
    for y = 1+half_sg_size : imf_width-half_sg_size
        %calculate Y coordinate for segment
        lowy=y-half_sg_size;
        highy=y+half_sg_size;
        if lowy < 1
            lowy = 1;
        end
        if highy > imf_height
            highy=imf_height;
        end
        
        %calculate Y coordinate for search window
        swlowy=y-half_sw_size;
        swhighy=y+half_sw_size;
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
            
        for x = 1+half_sg_size : imf_height-half_sg_size         
            %calculate X coodrinate for segment
            lowx=x-half_sg_size;
            highx=x+half_sg_size;
            
            if highx > imf_width 
                highx = imf_width;
            end
            if lowx < 1
                lowx = 1;
            end
            seg=imf(lowy:highy-1, lowx:highx-1);
            
            %calculate X coodrinate for search window
            swlowx=x-half_sw_size;
            swhighx=x+half_sw_size;
            
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
%             size(search_window)
%             subplot(1,2,1), imshow(seg,[]), title("seg");
%             subplot(1,2,2), imshow(search_window,[]), title("win");
            
%             imshow(search_window);
% disp returns coordinates within search window
            dist=x - (swlowx + pixel_disp(seg, search_window));
            disp(y,x)= dist;
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
    
    fid = fopen('test.txt','wt');
    for ii = 1:size(disp,1)
        fprintf(fid,'%g\t',disp(ii,:));
        fprintf(fid,'\n');
    end
    fclose(fid);
    
    imwrite(disp,"image.bmp");