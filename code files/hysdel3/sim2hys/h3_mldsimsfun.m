function h3_mldsimsfun(block)
% Level-2 M file S-Function for HYSDEL block

% Copyright is with the following author(s):
%
% (C) 2008-2010 Michal Kvasnica, Slovak University of Technology
%               michal.kvasnica@stuba.sk

% ------------------------------------------------------------------------
% Legal note:
%       This program is free software; you can redistribute it and/or
%       modify it under the terms of the GNU General Public
%       License as published by the Free Software Foundation; either
%       version 2.1 of the License, or (at your option) any later version.
%
%       This program is distributed in the hope that it will be useful,
%       but WITHOUT ANY WARRANTY; without even the implied warranty of
%       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%       General Public License for more details.
%
%       You should have received a copy of the GNU General Public
%       License along with this library; if not, write to the
%       Free Software Foundation, Inc.,
%       59 Temple Place, Suite 330,
%       Boston, MA  02111-1307  USA
%
% ------------------------------------------------------------------------

  setup(block);
  
function setup(block)
  
  %% Register number of dialog parameters   
  block.NumDialogPrms = 1;
  block.DialogPrmsTunable = {'Nontunable'};

  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 1;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
 
  block.InputPort(1).Dimensions        = block.DialogPrm(1).Data.nu;
  block.InputPort(1).DirectFeedthrough = true;
  
  block.OutputPort(1).Dimensions       = block.DialogPrm(1).Data.ny;

  %% Set block sample time
  block.SampleTimes = [block.DialogPrm(1).Data.Ts 0];

  %% Register methods
  if block.DialogPrm(1).Data.nx>=1
      block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);
      block.RegBlockMethod('InitializeConditions',@InitConditions);  
  end
  block.RegBlockMethod('Outputs', @Output);  

function DoPostPropSetup(block)

  block.NumDworks = 1;
  block.Dwork(1).Name = 'x0';
  block.Dwork(1).Dimensions  = block.DialogPrm(1).Data.nx;
  block.Dwork(1).DatatypeID      = 0;
  block.Dwork(1).Complexity      = 'Real';
  block.Dwork(1).UsedAsDiscState = true;

  
function InitConditions(block)
   
  block.Dwork(1).Data = block.DialogPrm(1).Data.x0;
  
function Output(block)

  if block.DialogPrm(1).Data.nx>=1
      [xn, sys] = h3_mldsim(block.DialogPrm(1).Data, block.Dwork(1).Data, block.InputPort(1).Data);
      block.Dwork(1).Data = xn;
  else
      [xn, sys] = h3_mldsim(block.DialogPrm(1).Data, [], block.InputPort(1).Data);
  end
  block.OutputPort(1).Data = sys;
