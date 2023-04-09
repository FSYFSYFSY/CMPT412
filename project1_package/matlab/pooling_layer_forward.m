function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.

    output.data = zeros([h_out * w_out * c, batch_size]);

    for i = 1 : batch_size

        NewData = reshape(input.data(:,i),[h_in, w_in, c]);
        OP_Index = 1;

        for j = 1 : c

            Mat = NewData(:,:,j);

            for m = 1 : stride : (h_in - stride + 1)
                for n = 1 : stride : (w_in - stride + 1)

                    Ker_Mat = reshape(Mat(n:n+k-1, m:m+k-1), [k, k]);
                    Max_Val = max(max(Ker_Mat));

                    output.data(OP_Index, i) = Max_Val;
                    OP_Index = OP_Index + 1;

                end
            end
        end
    end

end

