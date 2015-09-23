function [ transitions, labels ] = find_transitions(data, thresholds, transitions_tpl)

    % Label data based on thresholds
    labels = NaN(size(data));
    for i = 1:numel(thresholds)
        labels( isnan(labels) & data < thresholds(i) ) = i;
    end
    labels( isnan(labels) ) = i + 1;
   
    % Compress vector
    [labels_rr, indices] = remove_repetitions(labels);
    
    % Find transitions
    transitions = struct('sequence', {}, 'start', {}, 'stop', {});
    
    
    if ~iscell(transitions_tpl)
        transitions_tpl = {transitions_tpl};
    end
    
    for i = 1:numel(transitions_tpl)
        seq_length = numel(transitions_tpl{i});
        trans = find(find_sequence(labels_rr, transitions_tpl{i}));

        for j = 1:numel(trans)
            transitions(end + 1).sequence = i;
            transitions(end).start = indices(trans(j) + 1, 1);
            transitions(end).stop = indices(trans(j) + seq_length - 2, 2);
        end
    end
end

function flag = find_sequence(data, sequence)
    dims = size(data);
    dims(2) = dims(2) - numel(sequence) + 1;
    
    flag = true(dims);

    for i = 1:numel(sequence)
        flag = flag & ...
            sequence(i) == data(:, i + (1:dims(2)) - 1);
    end
end