Animation with Constraints
==========================

A test for changes in iOS 6 for animations with new layout changes with constraints.

In this sample project there are 3 blocks which are in a view which is a layout using constraints instead
of the conventional springs and struts. The animation moves the boxes down and up back to their original
position. Pushing on a view onto the navigation controller brings up a subview. Returning back to the home
view should keep the boxes in the same position but they are reset by the layout system which is triggered
by the view appearing again.

The goal with this sample project is to learn how to do animations and keep the changes even when leaving
and returning to the view. I could either adjust the constraints and trigger an animation to adjust the
positions of the views or somehow prevent the layout system from undoing the changes by the animation.

--
Brennan Stehling - @smallsharptools - 10/2012