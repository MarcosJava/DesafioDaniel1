//
//  ViewController.m
//  DesafioDaniel
//
//  Created by Marcos Felipe Souza on 01/04/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "ViewController.h"
#import "GestureViewController.h"



@interface ViewController ()

@end

@implementation ViewController

-(id) init{
    self = [super init];
    if(self){
        UIImage *image = [UIImage imageNamed:@"contat.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Musics" image:image tag:0];
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Listando Musica";
    }
    return self;
}

- (void) createPushRefresh{
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Atualizando ;)"];
    [self.tableView addSubview:self.refresh];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshTable {
    //TODO: refresh your data
    [self clearsListMusic];
    
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

-(void) clearsListMusic{
    [self.musicas removeAllObjects];
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    NSLog(@"Logging items from a generic query...");
    NSArray *musicasItunes = [everything items];
    
    for (MPMediaItem *song in musicasItunes) {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        [self.musicas addObject:songTitle];
        
        MPMediaItemArtwork *artwork =
        [song valueForProperty: MPMediaItemPropertyArtwork];
        UIImage *artworkImage =
        [artwork imageWithSize: _foto.bounds.size];
        
        if (artworkImage) {
            _foto.image = artworkImage;
        } else {
            _foto.image = [UIImage imageNamed: @"noArtwork.png"];
        }
        
        
        
        NSLog (@"%@", [musicasItunes[0] valueForProperty:MPMediaItemPropertyTitle]);
    }

}

-(void) createButtonBack {
    UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    self.navigationItem.backBarButtonItem = myBackButton;
}
- (void)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title = @"Musica Itunes";
    
    self.musicas = [NSMutableArray new];
    
    [self createPushRefresh];
    [self createButtonBack];
   
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    NSLog(@"Logging items from a generic query...");
    NSArray *musicasItunes = [everything items];
    
    for (MPMediaItem *song in musicasItunes) {
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        [self.musicas addObject:songTitle];
        NSLog (@"%@", songTitle);
    }
    NSLog(@"%lu", (unsigned long)self.musicas.count);
    
    
    //[self presentModalViewController: everything animated: YES];
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.musicas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MusicTableViewCell *cell = (MusicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UIImageView *imagem = [UIImageView new];
    imagem.image = [UIImage imageNamed:@"Music-4.jpg"];
    
    
    cell.imagemView.layer.cornerRadius = imagem.layer.cornerRadius;
    cell.imagemView.clipsToBounds = YES;
//    cell.imagemView.layer.borderWidth=2.0;
//    cell.imagemView.layer.masksToBounds = YES;
//    cell.imagemView.layer.borderColor=[[UIColor redColor] CGColor];
    cell.imagemView.image = imagem.image;

    cell.labelView.text = self.musicas[indexPath.row];

    NSLog(@"%@", self.musicas[indexPath.row]);
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
