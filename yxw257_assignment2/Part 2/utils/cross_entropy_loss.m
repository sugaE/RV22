function L = cross_entropy_loss(label, y_label, y_prob)

    L = mean(-log(y_prob), 'all');

end

