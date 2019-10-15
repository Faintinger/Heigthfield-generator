//  Author: Ali Ghahraei Figueroa
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

//  Function to interpolate 
// 
//  Arguments:
//  n -> used to get the size of the matrix
//  leftTop -> A(beginning,beginning)
//  rightTop -> A(beginning,end)
//  leftBottom -> A(end,beginning)
//  rightBottom -> A(end,end)

function [heightField] = interpolation(n, leftTop, rightTop, leftBottom, rightBottom)
    MATRIX_LENGTH = (2 ** n) + 1
    
    heightField(1, 1) = leftTop
    heightField(1, MATRIX_LENGTH) = rightTop
    heightField(MATRIX_LENGTH, 1) = leftBottom
    heightField(MATRIX_LENGTH, MATRIX_LENGTH) = rightBottom
    
    increment = MATRIX_LENGTH - 1
    
    interpolationStart = ceil(MATRIX_LENGTH/2)
    
    i = interpolationStart
    while i >= 2        
        for j = interpolationStart:increment:MATRIX_LENGTH
            distanceToEdge = i-1
            for k = i:increment:MATRIX_LENGTH
                heightField(k+distanceToEdge, j) = mean([heightField(k+distanceToEdge, j+distanceToEdge),heightField(k+distanceToEdge, j-distanceToEdge)])

                heightField(k-distanceToEdge, j) = mean([heightField(k-distanceToEdge, j+distanceToEdge),heightField(k-distanceToEdge, j-distanceToEdge)])

                heightField(k, j+distanceToEdge) = mean([heightField(k+distanceToEdge, j+distanceToEdge),heightField(k-distanceToEdge, j+distanceToEdge)])

                heightField(k, j-distanceToEdge) = mean([heightField(k+distanceToEdge, j-distanceToEdge),heightField(k-distanceToEdge, j-distanceToEdge)])
                

                heightField(k, j) = mean([heightField(k+distanceToEdge, j), heightField(k-distanceToEdge, j), heightField(k, j+distanceToEdge), heightField(k, j-distanceToEdge)])
            end
        end
        
        interpolationStart = ceil(interpolationStart/2)
        increment = increment/2
        i = i - floor(i/2)
    end
endfunction

//  Graph the provided example

function graphExample()
    n = 3
    [z] = interpolation(n, 1, 20, 5, 200)
    x = [1:1:2**n+1]
    plot3d(x,x,z)
endfunction
