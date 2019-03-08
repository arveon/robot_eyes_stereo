function y = disp_map(imf, ims)
    [imf_width, imf_height] = size(imf);
    sg_size = 10;
    sw_size = 30;
    
    disp=zeros(imf_width,imf_height);
    disp(:,:)=-1;
    for x = 1+sg_size/2 : imf_width-sg_size/2
        for y = 1+sg_size/2 : imf_height-sg_size/2
            %crop out a segment making sure 
            lowx=x-sg_size/2;
            highx=x+sg_size/2;
            lowy=y-sg_size/2;
            highy=y+sg_size/2;
            if lowx < 1
                lowx = 1;
            end
            if highx > imf_width
                highx=imf_width;
            end
            if highy >imf_height 
                highy = imf_height;
            end
            if lowy < 1
                lowy = 1;
            end
            seg=imf(lowx:highx, lowy:highy);
            
            %build the search window
            swlowx=x-sw_size/2;
            swhighx=x+sw_size/2;
            swlowy=y-sw_size/2;
            swhighy=y+sw_size/2;
            if swlowx < 1
                swlowx = 1;
            end
            if swhighx > imf_width
                swhighx=imf_width;
            end
            if swhighy >imf_height 
                swhighy = imf_height;
            end
            if swlowy < 1
                swlowy = 1;
            end
            search_window = ims(swlowx:swhighx, swlowy:swhighy);
%             imshow(search_window);
            disp(x,y)=pixel_disp(seg, search_window);
            
            clc
            x
            y
        end   
    end
    
    imshow(disp,[]);
    
    fid = fopen('test.txt','wt');
    for ii = 1:size(disp,1)
        fprintf(fid,'%g\t',disp(ii,:));
        fprintf(fid,'\n');
    end
    fclose(fid);
    
%     imwrite(disp,"image.png");