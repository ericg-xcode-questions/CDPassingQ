//
//  NameViewer.swift
//  CDPassingQ
//
//  Created by ericg on 1/9/22.
//
//
//  CompanyView.swift
//  ProductTracker
//
//  Created by ericg on 11/15/21.
//

import SwiftUI
import CoreData

enum TrustReason: String, Identifiable, CaseIterable
{
    var id: UUID
    {
        return UUID();
    }
    
    case unknown         = "Unknown";
    case legalOnly       = "Legal Only";
    case goodLabeling    = "Good Labeling";
    case facilityClean   = "Facility Clean";
    case detailedAnswers = "Detailed Answers";
    case unresponsive    = "Unresponsive";
}



extension TrustReason
{
    var title: String
    {
        switch self
        {
            case .unknown:
                return "Unknown";
                
            case .legalOnly:
                return "Legal Only";
                
            case .goodLabeling:
                return "Good Labeling";
                
            case .facilityClean:
                return "Facility Clean";
                
            case .detailedAnswers:
                return "Detailed Answers";
                
            case .unresponsive:
                return "Unresponsive";
        }
    }
}



struct NameViewer: View {
    @Environment( \.presentationMode )     var         presentationMode
    @Environment( \.managedObjectContext ) private var moc
    
    @State private var name: String = ""
    @State private var reason: TrustReason = .unknown

    var itemID: NSManagedObjectID?
    
    var body: some View {
        Form {
            Section( header: Text( "Information" ) ) {
                TextField( "Name", text: $name )
            }
            
            Section( header: Text( "Trust" ) ) {
                Picker( "Reason", selection: $reason ) {
                    ForEach( TrustReason.allCases ) { trustReason in
                        Text( trustReason.title ).tag( trustReason )
                    }
                }
            }
        }
        .toolbar {
            Button() {
                if ( saveName() ) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text( "Save" )
            }
        }
        .onAppear {
            print( "on appear" )
            
            guard let theID = itemID,
                  let item = moc.object( with: theID ) as? Item else {
                      return
                  }
            
            print( "passed guard" )
            
            if let itemName = item.name {
                name = itemName
            }
            
            print( name )
        }
    }
    
    
    
    private func saveName() -> Bool {
        let item = Item( context: moc )
        
        do {
            print( self.name )
            
            item.name = self.name
            
            try moc.save()
            
            return true
        } catch {
            print( error )
            print( error.localizedDescription )
        }
        
        self.moc.rollback();
        
        return false
    }
}



struct NameViewer_Previews: PreviewProvider {
    static var previews: some View {
        NameViewer()
    }
}
