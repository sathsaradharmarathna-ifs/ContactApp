//
//  ContactCell.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-22.
//

import UIKit

protocol CellButtonActions {
    func didDeleteCell(model:Contact);
    func didEditCell(model:Contact);
}

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var contactLbl: UILabel!
    
    var delegate:CellButtonActions?
    var modelValue:Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = UIColor.tertiarySystemGroupedBackground
        bgView.addCornerRadious(radious: 7)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(model:Contact){
        modelValue = model
        nameLbl.text = model.fullName
        contactLbl.text = model.phoneNumber
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let index = modelValue else { return }
        delegate?.didDeleteCell(model: index)
    }
    
    @IBAction func editAction(_ sender: Any) {
        guard let index = modelValue else { return }
        delegate?.didEditCell(model: index)
    }
}
