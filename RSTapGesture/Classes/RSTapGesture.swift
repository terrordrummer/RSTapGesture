//
//  RSTapGesture.swift
//  Roberto Sartori
//
//  Created by Roberto Sartori on 23.11.18.
//  Copyright © 2018 Roberto Sartori. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

/// Implements a nicer tap gesture manager with event closures chaining syntax
public
class RSTapGesture: UIGestureRecognizer {

    // MARK: - TYPEALIAS

    public typealias EventCallback = ((RSTapGesture) -> Void)

    // MARK: - PRIVATE

    private var onTouchDownEvent: EventCallback?
    private var onTouchUpInsideEvent: EventCallback?
    private var onTouchUpOutsideEvent: EventCallback?
    private weak var addedView: UIView?

    // MARK: - Initializers

    convenience public init(in view: UIView) {
        self.init()
        self.add(to: view)
    }

    // MARK: - Public
    
    /// Adds the gesture recognizer to a view
    ///
    /// - Parameter view:
    /// - Returns:
    @discardableResult public func add(to view: UIView) -> RSTapGesture {
        view.addGestureRecognizer(self)
        view.isUserInteractionEnabled = true
        addedView = view
        return self
    }

    /// Sets the touch down closure
    ///
    /// - Parameter callback:
    /// - Returns:
    @discardableResult public func onTouchDown(_ callback: @escaping EventCallback) -> RSTapGesture {
        onTouchDownEvent = callback
        return self
    }

    /// Sets the touch up inside closure
    ///
    /// - Parameter callback:
    /// - Returns:
    @discardableResult public func onTouchUpInside(_ callback: @escaping EventCallback) -> RSTapGesture {
        onTouchUpInsideEvent = callback
        return self
    }

    /// Sets the touch up outside closure
    ///
    /// - Parameter callback:
    /// - Returns:
    @discardableResult public func onTouchUpOutside(_ callback: @escaping EventCallback) -> RSTapGesture {
        onTouchUpOutsideEvent = callback
        return self
    }


    /// Remove the tap gesture from the view

    public func remove() {
        if let view = addedView {
            view.removeGestureRecognizer(self)
        }
    }

    // MARK: - Private fuctions

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .began
            DispatchQueue.main.async {
                self.onTouchDownEvent?(self)
            }
        }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {

    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {

    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            self.state = .ended
            if addedView?.bounds.contains(touch.location(in: addedView)) == true {
                // touch up inside,
                DispatchQueue.main.async {
                    self.onTouchUpInsideEvent?(self)
                }
            } else {
                // touch up outside,
                DispatchQueue.main.async {
                    self.onTouchUpOutsideEvent?(self)
                }
            }
        } else {
            // gesture failed
            self.state = .cancelled
        }
    }
}
