img_normalize('rose1024.tif', 'n');

function img_normalize(filePath, mode)
    img = imread(filePath);

    if (mode == 'u')
        fprintf('Histogram\n');

        imhist(img);
        
        saveas(gcf, sprintf('histograma_u.png'));
    elseif (mode == 'n')
        fprintf('Normalized Histogram\n');

        histogram(img, 'Normalization', 'probability');
        
        saveas(gcf, sprintf('histograma_n.png'));
    else
        fprintf('Possible options for mode: u or n\n');
    end
end