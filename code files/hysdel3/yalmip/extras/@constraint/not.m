function X = not(X)
% Internal class for constraint list

% Author Johan L?fberg
% $Id: not.m,v 1.2 2009-02-25 12:29:25 joloef Exp $

superiorto('sdpvar');
superiorto('double');

% Try to evaluate

if length(X.List)>3
    error('Negation can only be applied to BINARY relations')
else
    switch X.List{2}
        case '<'
            X.List{2} = '>';
            X.Evaluated{1} = -X.Evaluated{1};
        case '>'
            X.List{2} = '<';
            X.Evaluated{1} = -X.Evaluated{1};
        case '=='
            % A simple inequality has to be converted to an expression which
            % most likely will be a mixed-integer model....
            A = X.List{1}; B = X.List{3};
            if ( isa(A,'sdpvar') && isa(B,'sdpvar') && ...
                    is(A,'binary') && is(B,'binary') ) || ...
                    ( isa(A, 'sdpvar') && is(A, 'binary') && ...
                    isa(B, 'double') && ismember(B, [0 1]) ) || ...
                    ( isa(A, 'double') && ismember(A, [0 1]) && ...
                    isa(B, 'sdpvar') && is(B, 'binary') )
                X = or(and(A, not(B)), and(not(A), B));
            else
                X = X.List{1} ~= X.List{3};
            end
        otherwise
            error('Negation cannot be applied on this operator')
    end
end
