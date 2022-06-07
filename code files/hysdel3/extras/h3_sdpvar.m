classdef h3_sdpvar
	properties
		var
	end
	
	methods
		function obj = h3_sdpvar(varargin)
			obj.var = sdpvar(varargin{:});
			superiorto('sdpvar', 'binvar', 'sdpvar', 'lmi', 'constraint')


		end
		
		
		function out = and(varargin)
			a = h3_tos(varargin{:});
			out = and(a{:});
		end
		function out = any(varargin)
			a = h3_tos(varargin{:});
			out = any(a{:});
		end
		function out = binary(varargin)
			a = h3_tos(varargin{:});
			out = binary(a{:});
		end
		function out = cat(varargin)
			a = h3_tos(varargin{:});
			out = cat(a{:});
		end
		function out = le(varargin)
			a = h3_tos(varargin{:});
			out = le(a{:});
		end
		function out = lt(X, Y)

			o = h3_tos(X, Y);
			X = o{1}; Y = o{2};
			if isa(X,'blkvar')
				X = sdpvar(X);
			end
			
			if isa(Y,'blkvar')
				Y = sdpvar(Y);
			end
			
			
			do_binary = false;
			if nargin == 2 && isa(Y, 'sdpvar') && isa(X, 'sdpvar')
				if is(X, 'binary') && is(Y, 'binary') && ...
						~is(X, 'compound') && ~is(Y, 'compound') && ...
						length(getvariables(X)) == 1 && length(getvariables(Y)) == 1
					do_binary = true;
				end
			end
			
			% if ~isempty(H3_AVOID_BINARY_IMPLICATION)
			%     do_binary = false;
			% end
			
			if do_binary
				try
					y = or(not(X), Y);
				catch
					error(lasterr);
				end
				return
			end
			
			try
				y = constraint(X,'<',Y);
			catch
				error(lasterr)
			end
			a = h3_tos(varargin{:});
			out = lt(a{:});
		end
		function out = ge(varargin)
			a = h3_tos(varargin{:});
			out = ge(a{:});
		end
		function out = gt(X, Y)
			out = lt(Y, X);
		end
		function out = eq(varargin)
			a = h3_tos(varargin{:});
			out = eq(a{:});
		end
		function out = ne(varargin)
			a = h3_tos(varargin{:});
			out = ne(a{:});
		end
		function out = true(varargin)
			a = h3_tos(varargin{:});
			out = true(a{:});
		end
		function out = false(varargin)
			a = h3_tos(varargin{:});
			out = false(a{:});
		end
		function out = or(varargin)
			a = h3_tos(varargin{:});
			out = or(a{:});
		end
		function out = all(varargin)
			a = h3_tos(varargin{:});
			out = all(a{:});
		end
		function out = uplus(varargin)
			a = h3_tos(varargin{:});
			out = uplus(a{:});
		end
		function out = uminus(varargin)
			a = h3_tos(varargin{:});
			out = uminus(a{:});
		end
		function out = times(varargin)
			a = h3_tos(varargin{:});
			out = times(a{:});
		end
		function out = mldivide(varargin)
			a = h3_tos(varargin{:});
			out = mldivide(a{:});
		end
		function out = not(varargin)
			a = h3_tos(varargin{:});
			out = not(a{:});
		end
	end
	
end


function out = h3_tos(varargin)

if false
	f = {'and', 'any', 'binary', 'cat', 'le', 'lt', 'ge', 'gt', 'eq', 'ne', ...
		'true', 'false', 'or', 'all', 'uplus', 'uminus', 'times', 'mldivide', ...
		'not'}
	
	for i = 1:length(f)
		fprintf('function out = %s(varargin)\n', f{i});
		fprintf('a = h3_tos(varargin{:});\n');
		fprintf('out = %s(a{:});\n', f{i});
		fprintf('end\n');
	end
	
end

out = cell(1, length(varargin));
for i = 1:length(varargin)
	if isa(varargin{i}, 'h3_sdpvar')
		out{i} = varargin{i}.var;
	else
		out{i} = varargin{i};
	end
end

end
