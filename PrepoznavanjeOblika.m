function f = PrepoznavanjeOblika(ImageFile,bmp)
    slika=imread('prepoznavanje1.bmp');
    figure, imshow(slika), title('Originalna slika');
    
    grayscale=rgb2gray(slika);
    figure, imshow(grayscale), title('Crno-bijela slika');
    
    %treshold
    treshold=graythresh(grayscale);
    binarna=im2bw(grayscale, treshold);
    figure, imshow(binarna), title('Binary');
    
    %inverz
    binarna=~binarna;
    imshow(binarna), title('Inverz');
    
    [B,L] = bwboundaries(binarna, 'noholes');
    
    STATS = regionprops(L, 'all');
    
figure, imshow(slika), title('Rezultati');

hold on
for i = 1 : length(STATS)
  centroid = STATS(i).Centroid;
  
   if (STATS(i).Extent<0.85 && STATS(i).Extent>0.70)
   if (STATS(i).MajorAxisLength == STATS(i).MinorAxisLength)
          plot(centroid(1),centroid(2));
          text(STATS(i).Centroid(1), STATS(i).Centroid(2),'krug', 'HorizontalAlignment', 'center', 'color', 'cyan'); 
   elseif(STATS(i).MajorAxisLength ~= STATS(i).MinorAxisLength)
          plot(centroid(1),centroid(2));
          text(STATS(i).Centroid(1), STATS(i).Centroid(2),'elipsa', 'HorizontalAlignment', 'center', 'color', 'cyan'); 
   end
   elseif (STATS(i).Extent>0.85)
       if (STATS(i).MajorAxisLength ~= STATS(i).MinorAxisLength)
          plot(centroid(1),centroid(2));
          text(STATS(i).Centroid(1), STATS(i).Centroid(2),'pravougaonik', 'HorizontalAlignment', 'center', 'color', 'cyan'); 
       elseif ((STATS(i).MajorAxisLength == STATS(i).MinorAxisLength))
          plot(centroid(1),centroid(2));
          text(STATS(i).Centroid(1), STATS(i).Centroid(2),'kvadrat', 'HorizontalAlignment', 'center', 'color', 'cyan'); 
       end
   elseif ((STATS(i).Perimeter)^2/(4*pi*STATS(i).Area)>1.45)
          plot(centroid(1),centroid(2));
          text(STATS(i).Centroid(1), STATS(i).Centroid(2),'trougao', 'HorizontalAlignment', 'center', 'color', 'cyan'); 
       
   else
          text(STATS(i).Centroid(1), STATS(i).Centroid(2),'nepoznato', 'HorizontalAlignment', 'center', 'color', 'cyan'); 
  end
end
return