//
//  SlideInTransition.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    //Añadimos una bandera
    var isPresenting = false
    let dimmingView = UIView()
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = fromViewController.view.bounds.height
        
        if isPresenting{
            //Añadimos el dimming View
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            //Añadimos la vista Menu a la viewContainer
            containerView.addSubview(toViewController.view)
            
            //configurando tamaño sobre la pantalla
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
            
        }
        
        //Animacion de presentacion en la pantalla
        let tranform = {
            
            self.dimmingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        //Animacion de regreso en dissmis
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        //Animacion de la transicion
        let duration = transitionDuration(using: transitionContext)
        let isCanceled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? tranform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCanceled)
        }

    }
    
    

}
