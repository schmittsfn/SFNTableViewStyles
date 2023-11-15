//
//  ViewController.swift
//  SFNTableViewStyles
//
//  Created by Stefan Schmitt on 15/11/2023.
//

import UIKit

final class ViewController: UITableViewController {

    private enum Section {
        case main
    }
    
    private struct CharacterName: Hashable {
        let title: String
        let subtitle: String
        let identifier = UUID()
    }

    private static let kCharacterNames = [
        CharacterName(title: "Arthur", subtitle: "Dent"),
        CharacterName(title: "Ford", subtitle: "Prefect"),
        CharacterName(title: "Zaphod", subtitle: "Beeblebrox"),
        CharacterName(title: "Trillian", subtitle: "(Tricia McMillan)"),
        CharacterName(title: "Marvin", subtitle: "the Paranoid Android"),
        CharacterName(title: "Slartibartfast", subtitle: ""),
        CharacterName(title: "Eddie", subtitle: "the Computer"),
        CharacterName(title: "Deep", subtitle: "Thought"),
        CharacterName(title: "The", subtitle: "Guide (Narrator)"),
        CharacterName(title: "Vogons", subtitle: ""),
        CharacterName(title: "Prostetnic", subtitle: "Vogon Jeltz"),
        CharacterName(title: "Fenchurch", subtitle: ""),
        CharacterName(title: "Random", subtitle: "Dent"),
        CharacterName(title: "Agrajag", subtitle: ""),
        CharacterName(title: "Wowbagger", subtitle: "the Infinitely Prolonged"),
        CharacterName(title: "Lintilla", subtitle: ""),
        CharacterName(title: "Zarniwoop", subtitle: ""),
        CharacterName(title: "Roosta", subtitle: ""),
        CharacterName(title: "Gag", subtitle: "Halfrunt"),
        CharacterName(title: "Majikthise and", subtitle: "Vroomfondel")
    ]

    private var dataSource: UITableViewDiffableDataSource<Section, CharacterName>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITableView.Style.insetGrouped"
        
        configureTableView()
        configureDataSource()
        applyInitialSnapshot()
    }
    
    func configureTableView() {
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, CharacterName>(tableView: tableView) {
            (tableView, indexPath, characterName) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = characterName.title
            cell.detailTextLabel?.text = characterName.subtitle
            cell.imageView?.image = UIImage(systemName: "person")!
            return cell
        }
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterName>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Self.kCharacterNames, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


final class SubtitleTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
